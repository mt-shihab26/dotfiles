return {
    "mfussenegger/nvim-dap",
    config = function()
        local dap = require "dap"
        local map = vim.keymap.set

        local opts = function(opts)
            return vim.tbl_extend("force", { noremap = true, silent = true, remap = false }, opts or {})
        end

        map("n", "<leader>dt", dap.toggle_breakpoint, opts { desc = "toggle breakpoint (dap)" })
        map("n", "<leader>dc", dap.continue, { desc = "continue debugger (dap)" })

        -- map("n", "<F5>", dap.continue)
        -- map("n", "<F10>", dap.step_over)
        -- map("n", "<F11>", dap.step_into)
        -- map("n", "<F12>", dap.step_out)
        -- map("n", "<Leader>b", dap.toggle_breakpoint)
        -- map("n", "<Leader>B", dap.set_breakpoint)
        -- map("n", "<Leader>lp", function()
        --     dap.set_breakpoint(nil, nil, vim.fn.input "Log point message: ")
        -- end)
        -- map("n", "<Leader>dr", dap.repl.open())
        -- map("n", "<Leader>dl", dap.run_last())
        -- map({ "n", "v" }, "<Leader>dh", function()
        --     require("dap.ui.widgets").hover()
        -- end)
        -- map({ "n", "v" }, "<Leader>dp", function()
        --     require("dap.ui.widgets").preview()
        -- end)
        -- map("n", "<Leader>df", function()
        --     local widgets = require "dap.ui.widgets"
        --     widgets.centered_float(widgets.frames)
        -- end)
        -- map("n", "<Leader>ds", function()
        --     local widgets = require "dap.ui.widgets"
        --     widgets.centered_float(widgets.scopes)
        -- end)
    end,
}
