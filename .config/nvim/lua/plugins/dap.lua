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

-- open the ui when a session starts and close it when the session ends
dap.listeners.before.attach.dapui_config = dapui.open
dap.listeners.before.launch.dapui_config = dapui.open
dap.listeners.before.event_terminated.dapui_config = dapui.close
dap.listeners.before.event_exited.dapui_config = dapui.close
