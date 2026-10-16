# nvim-dap: step out / step back / step in break with gdb

Status: **partly fixed, still open.** Written 2026-10-16.

Debugging C/C++ in Neovim with nvim-dap + nvim-dap-ui and gdb's built-in debug adapter (`gdb --interpreter=dap`,
gdb 17.2), stepping gets stuck: after a step out, step in and step over stop working and show
`No stopped threads. Cannot move`. Step back shows `Debug Adapter does not support stepping backwards`.

Relevant config:

- `.config/nvim/lua/plugins/dap.lua`: setup, and wrappers around nvim-dap internals
- `.config/nvim/lua/lib/dap.lua`: helper functions
- `.config/nvim/lua/debuggers/native.lua`: the gdb adapter (`type = "native"`)
- Error log: `~/.local/state/nvim/dap-errors.log`, open it with `:DapErrorLog`

## What the log shows

From a real session on `samples/c/main.c` (12:13–12:14). The repeated lines come from pressing the key several times:

```
12:13:48  native  Error on stepOut: "finish" not meaningful in the outermost frame.   (x12, stepping out of main)
12:13:57  native  Debug Adapter does not support stepping backwards.                   (x3)
12:13:58  native  No stopped threads. Cannot move                                      (x6)
12:14:10  native  Debug Adapter does not support stepping backwards.                   (x11)
12:14:13  native  No stopped threads. Cannot move                                      (x5)
```

The step back messages come from nvim-dap's own `step_back`. Our gdb step back only runs while a thread is stopped,
so by 12:13:57 nvim-dap already thought nothing was paused.

## Causes found

### 1. nvim-dap doesn't undo "running" when a step is refused (fixed)

`Session:_step` in nvim-dap calls `clear_running()` (clears `stopped_thread_id`, sets `thread.stopped = false`)
**before** sending the step request. If the adapter answers with an error, nothing marks the thread stopped again.
The program is still paused, but every later step fails with `No stopped threads. Cannot move`.

gdb refuses `stepOut` in the outermost frame (`"finish" not meaningful in the outermost frame.`), so one step out
in `main` used to break the whole session.

Fix: the `Session:request` wrapper in `plugins/dap.lua` wraps the callback for
`next/stepIn/stepOut/stepBack/continue/reverseContinue`. On an error it calls `lib_dap.restore_stopped_thread()`,
which sets the thread stopped again, puts the current frame back and refreshes the dap-ui toolbar. Verified: after
any number of refused step outs, step in and step over still work.

This is an nvim-dap bug and should be reported upstream (see below).

### 2. gdb's adapter doesn't say it supports step back (worked around)

gdb can run backwards, but only while it is recording (`record full`, then `reverse-next` / `reverse-finish`). Its DAP
adapter doesn't set `supportsStepBack`, so nvim-dap refuses `step_back()` without sending anything. codelldb doesn't
support it either.

Workaround in `lib/dap.lua`:

- `start_gdb_recording`: on the first stop of a gdb session, runs `record full` and
  `set record full stop-at-limit off`
- `step_back`: sends `reverse-next` as a repl `evaluate` (also used by the toolbar button through
  `_G._dapui.step_back`)
- `stop_gdb_recording`: runs `record stop` before every `continue`, otherwise continue stops at the end of the
  history and again before the program exits; recording starts again at the next stop

Limitation: you can only step back through what was stepped since the last stop that followed a continue. This is
not full history.

### 3. Stepping off the end of `main` while recording leaves gdb running (open)

Reproduced on `samples/c/main.c`:

1. Breakpoint in `main`, step down to `return 0;`, step into: stops in `_exit()` (no source), because the recorder
   stops before the `exit_group` syscall
2. Step back: lands in `???()` (no source)
3. Step back again: `Error on reverse-next: Cannot find bounds of current function`
4. Step over: no stop event ever arrives. gdb is running or stuck, nvim-dap has cleared the stopped thread, and
   from here every step gives `No stopped threads. Cannot move` (the same as the log above)

Without recording, stepping off the end of `main` just lets the program exit and the session ends.

### 4. Forward steps after a step back behave oddly (open)

After a step back gdb is replaying the recorded history, and forward steps replay it too. Seen on `samples/c/main.c`:

- step out of `sum` stopped at `sum:10` instead of returning to `main`
- step into at `main:25` (`printf("sum: %d\n", sum(numbers, 3));`) went to `main:26` instead of into `sum`

Ordinary steps (step over through history and past its end) worked.

## Reproduce

Headless test scripts used for the cases above call nvim-dap from `nvim --headless` with this config, so they go
through the same wrappers:

```lua
dap.run({ type = "native", request = "launch", name = "t", program = "<compiled samples/c/main>", cwd = "<dir>" })
-- then dap.step_over / dap.step_into / dap.step_out / require("lib.dap").step_back, checking
-- dap.session().stopped_thread_id and dap.session().current_frame after each
```

Compile with `cc -g samples/c/main.c -o main`.

## Next steps

- [ ] Case 3: don't record (or `record stop`) once the program leaves frames with source, e.g. when the stop
      frame has no `source`; or stop recording when stepping from the last line of `main`
- [ ] Case 3: when a step gets no stop event within a few seconds, show a clear message instead of leaving the
      session in a "running" state nobody can step out of
- [ ] Case 4: decide whether forward steps while replaying should first `record goto end` (jump back to live) so
      step in / step out behave normally, at the cost of losing the replay position
- [ ] Report case 1 upstream to [mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap): `_step` should
      restore the stopped thread when the step request fails
- [ ] Alternative for real reverse debugging: [nvim-dap-rr](https://github.com/jonboh/nvim-dap-rr) records with
      `rr` and debugs through cpptools, whose adapter supports step back; needs `rr` and cpptools installed (not tried)
- [ ] Filter the harmless `variables` failures (`notStopped`, `invalid variablesReference`) out of the error log;
      they come from dap-ui asking for variables while a step is running
