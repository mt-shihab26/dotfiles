local dap = require "dap"

-- the debugger used for C/C++/Rust: "gdb" or "codelldb"
-- configurations with `type = "native"` (also in debug.json) use it
-- local native_debugger = "codelldb" -- change to "gdb" to switch
local native_debugger = "gdb" -- change to "codelldb" to switch

-- compile the current file with debug info and return the path of the executable
local function build(compiler)
    return function()
        local out = vim.fn.tempname()
        local cmd = vim.list_extend(vim.deepcopy(compiler), { vim.fn.expand "%:p", "-o", out })
        local res = vim.system(cmd, { text = true }):wait()
        if res.code ~= 0 then
            vim.notify(res.stderr, vim.log.levels.ERROR)
            return dap.ABORT
        end
        return out
    end
end

local function pick_executable()
    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
end

local function configurations(compiler)
    return {
        {
            type = "native",
            request = "launch",
            name = "Build and launch file",
            program = build(compiler),
            cwd = "${workspaceFolder}",
        },
        {
            type = "native",
            request = "launch",
            name = "Launch executable",
            program = pick_executable,
            cwd = "${workspaceFolder}",
        },
    }
end

dap.adapters.codelldb = {
    type = "executable",
    command = "codelldb",
}

-- gdb 14+ has a built-in debug adapter
dap.adapters.gdb = {
    type = "executable",
    command = "gdb",
    args = { "--interpreter=dap" },
}

dap.adapters.native = function(callback)
    callback(dap.adapters[native_debugger])
end

-- reverse debugging (step back, reverse continue) replays an rr recording through cpptools:
--   rr record ./program          record a run
--   rr replay -s 50505 -k        serve the last recording, then pick "rr" in the configuration menu
dap.adapters.cppdbg = {
    id = "cppdbg",
    type = "executable",
    command = "OpenDebugAD7",
}

dap.configurations.c = configurations { "cc", "-g" }
dap.configurations.cpp = configurations { "c++", "-g" }
dap.configurations.rust = configurations { "rustc", "-g" }

-- a missing or half-installed nvim-dap-rr must not abort startup (and every config loaded after it)
local ok, rr = pcall(require, "nvim-dap-rr")
if ok then
    table.insert(dap.configurations.c, rr.get_config())
    table.insert(dap.configurations.cpp, rr.get_config())
    table.insert(dap.configurations.rust, rr.get_rust_config())
end
