return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "rcarriga/nvim-dap-ui",
        "leoluz/nvim-dap-go",
    },
    config = function()
        local dap = require "dap"
        local dap_ui = require "dapui"
        local dap_ui_widgets = require "dap.ui.widgets"

        dap_ui.setup()

        dap.listeners.before.attach.dapui_config = dap_ui.open
        dap.listeners.before.launch.dapui_config = dap_ui.open
        dap.listeners.before.event_terminated.dapui_config = dap_ui.close
        dap.listeners.before.event_exited.dapui_config = dap_ui.close

        local opts = function(desc)
            return { noremap = true, silent = true, remap = false, desc = desc }
        end

        local set_log_print = function()
            dap.set_breakpoint(nil, nil, vim.fn.input "Log point message: ")
        end

        local show_frames = function()
            dap_ui_widgets.centered_float(dap_ui_widgets.frames)
        end

        local show_scopes = function()
            dap_ui_widgets.centered_float(dap_ui_widgets.scopes)
        end

        local map = vim.keymap.set

        -- break point management
        map("n", "<leader>dt", dap.toggle_breakpoint, opts "toggle breakpoint (dap)")
        map("n", "<leader>db", dap.set_breakpoint, opts "set breakpoint (dap)")
        map("n", "<leader>dB", set_log_print, opts "set log point (dap)")

        -- step controls
        map("n", "<leader>dc", dap.continue, opts "continue debugger (dap)")
        map("n", "<leader>do", dap.step_over, opts "step over (dap)")
        map("n", "<leader>di", dap.step_into, opts "step into (dap)")
        map("n", "<leader>du", dap.step_out, opts "step out (dap)")

        -- debug session management
        map("n", "<leader>dr", dap.repl.open, opts "open REPL (dap)")
        map("n", "<leader>dl", dap.run_last, opts "run last (dap)")

        -- widgets
        map({ "n", "v" }, "<leader>dh", dap_ui_widgets.hover, opts "hover widgets (dap)")
        map({ "n", "v" }, "<leader>dp", dap_ui_widgets.preview, opts "preview widgets (dap)")
        map("n", "<leader>df", show_frames, opts "show frames (dap)")
        map("n", "<leader>ds", show_scopes, opts "show scopes (dap)")

        -- connects server

        require("dap-go").setup()
        require("utils.dap-rust").setup()
    end,
}
