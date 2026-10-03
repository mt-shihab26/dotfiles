local dap = require "dap"

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
            type = "codelldb",
            request = "launch",
            name = "Build and launch file",
            program = build(compiler),
            cwd = "${workspaceFolder}",
        },
        {
            type = "codelldb",
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

dap.configurations.c = configurations { "cc", "-g" }
dap.configurations.cpp = configurations { "c++", "-g" }
dap.configurations.rust = configurations { "rustc", "-g" }
