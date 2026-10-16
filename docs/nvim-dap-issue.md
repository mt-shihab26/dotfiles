**Title:** Thread stays marked as running when the adapter rejects a step request ("No stopped threads. Cannot move")

---

### Debug adapter definition and debug configuration

gdb's built-in debug adapter, but this works the same with any adapter that can answer a step request with an error.

```lua
local dap = require("dap")

dap.adapters.gdb = {
  type = "executable",
  command = "gdb",
  args = { "--interpreter=dap" },
}

dap.configurations.c = {
  {
    type = "gdb",
    request = "launch",
    name = "Launch",
    program = function()
      return vim.fn.getcwd() .. "/main"
    end,
    cwd = "${workspaceFolder}",
  },
}
```

### Debug adapter version

GNU gdb (GDB) 17.2

nvim-dap: `cfa2d58` (master, 2026-09-08)
Neovim: v0.12.5

### Steps to Reproduce

1. Save this as `main.c` and build it with `cc -g main.c -o main`:

   ```c
   #include <stdio.h>

   int main(void) {
       int x = 1;
       printf("%d\n", x);
       return 0;
   }
   ```

2. Open `main.c`, set a breakpoint on `int x = 1;` and start debugging with `:DapContinue`.
3. When it stops in `main`, run `:DapStepOut`. gdb rejects it because `main` is the outermost frame:
   `Error on stepOut: "finish" not meaningful in the outermost frame.`
4. Run `:DapStepOver` (or `:DapStepInto`, `:DapStepOut`).

### Expected Result

The rejected step out leaves the program where it was. The program is still paused (the adapter sent no `continued`
event), so the step over in step 4 goes to the next line.

### Actual Result

Step 4 and every later step fail with:

```
No stopped threads. Cannot move
```

`dap.session().stopped_thread_id` is `nil` and the thread's `stopped` is `false`, although the program is still
paused in gdb. The stopped-line sign is also gone. The only way out is to end the session.

### Cause

`Session:_step` calls `clear_running(self, thread_id)` before it sends the step request. That clears
`stopped_thread_id`, sets `thread.stopped = false` and removes the `DapStopped` sign. If the adapter then answers the
request with an error, the callback only shows the error:

```lua
clear_running(self, thread_id)
self:request(step, params, function(err)
  if err then
    utils.notify('Error on '.. step .. ': ' .. tostring(err), vim.log.levels.ERROR)
  end
  progress.report('Running')
end)
```

Nothing restores the stopped state, so the next `_step` takes the `paused_threads` branch, finds no stopped thread and
gives up with "No stopped threads. Cannot move".

A failed response means the adapter didn't resume the thread, so I think the state should be put back on error.
Something like this:

```lua
local frame = self.current_frame
clear_running(self, thread_id)
self:request(step, params, function(err)
  if err then
    utils.notify('Error on '.. step .. ': ' .. tostring(err), vim.log.levels.ERROR)
    local thread = self.threads[thread_id]
    if thread and not self.stopped_thread_id then
      self.stopped_thread_id = thread_id
      thread.stopped = true
      self:_frame_set(frame)  -- puts the DapStopped sign back
    end
    return
  end
  progress.report('Running')
end)
```

`restart_frame` uses `clear_running(self)` before a request in the same way, so it may need the same change.

For now I work around it in my config by wrapping `Session.request`, so the step callback restores the thread on
error. That works: after a rejected step out, step over/into keep working. I can open a PR with the change above if
you'd like.
