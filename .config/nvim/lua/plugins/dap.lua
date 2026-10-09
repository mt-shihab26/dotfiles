vim.pack.add {
    {
        src = "https://github.com/mfussenegger/nvim-dap",
        version = "master",
    },
    {
        src = "https://github.com/nvim-neotest/nvim-nio",
        version = vim.version.range "1",
    },
    {
        src = "https://github.com/rcarriga/nvim-dap-ui",
        version = "master",
    },
    {
        src = "https://github.com/leoluz/nvim-dap-go",
        version = "main",
    },
    {
        src = "https://github.com/mfussenegger/nvim-jdtls",
        version = "master",
    },
}

local dap = require "dap"
local dapui = require "dapui"
local debuggers = require "lists.debuggers"

dapui.setup {}

-- debug adapters (dlv, codelldb, debugpy, ...) are installed by Mason, see lists/binaries.lua
for _, debugger_name in ipairs(debuggers) do
    require("debuggers." .. debugger_name)
end

vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticError" })
vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DiagnosticError" })
vim.fn.sign_define("DapLogPoint", { text = "◉", texthl = "DiagnosticInfo" })
vim.fn.sign_define("DapStopped", { text = "→", texthl = "DiagnosticWarn", linehl = "CursorLine" })

-- per-project configurations from .dap/debug.json (same format as .vscode/launch.json)
dap.providers.configs["project-debug-json"] = function()
    return require("dap.ext.vscode").getconfigs(vim.fn.getcwd() .. "/.dap/debug.json")
end

-- run a configuration's `preLaunchCommand` (e.g. a build script from .vscode/launch.json) before launching,
-- and abort the launch if it fails
dap.listeners.on_config["pre-launch-command"] = function(config)
    if not config.preLaunchCommand then
        return config
    end
    config = vim.deepcopy(config)

    local co = coroutine.running()
    vim.notify("Running " .. config.preLaunchCommand)
    vim.system({ "sh", "-c", config.preLaunchCommand }, { text = true, cwd = vim.fn.getcwd() }, function(res)
        vim.schedule(function()
            coroutine.resume(co, res)
        end)
    end)
    local res = coroutine.yield()

    if res.code ~= 0 then
        vim.notify(res.stdout .. res.stderr, vim.log.levels.ERROR)
        config.program = dap.ABORT
    end
    return config
end

-- open the ui when a session starts and close it when the session ends
dap.listeners.before.attach.dapui_config = dapui.open
dap.listeners.before.launch.dapui_config = dapui.open
dap.listeners.before.event_terminated.dapui_config = dapui.close
dap.listeners.before.event_exited.dapui_config = dapui.close
