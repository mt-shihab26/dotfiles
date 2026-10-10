local dap = require "dap"

-- the debugger used for C/C++/Rust: "gdb" or "codelldb"
-- configurations with `type = "native"` (also in debug.json) use it
local native_debugger = "codelldb" -- change to "gdb" to switch
-- local native_debugger = "gdb" -- change to "codelldb" to switch

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

dap.configurations.c = configurations { "cc", "-g" }
dap.configurations.cpp = configurations { "c++", "-g" }
dap.configurations.rust = configurations { "rustc", "-g" }
