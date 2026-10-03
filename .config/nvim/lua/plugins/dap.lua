vim.pack.add {
    {
        src = "https://github.com/mfussenegger/nvim-dap",
    },
    {
        src = "https://github.com/nvim-neotest/nvim-nio",
    },
    {
        src = "https://github.com/rcarriga/nvim-dap-ui",
    },
    {
        src = "https://github.com/leoluz/nvim-dap-go",
    },
}

local dap = require "dap"
local dapui = require "dapui"
local dap_go = require "dap-go"

dapui.setup {}
-- delve (dlv) is installed by Mason, see lists/binaries.lua
dap_go.setup {}

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
