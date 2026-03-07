return {
    "stevearc/conform.nvim",
    enabled = true,
    opts = {
        formatters_by_ft = require "lists.formatters",
        format_on_save = {
            timeout_ms = 5000,
            lsp_format = "fallback",
        },
    },
    config = function(_, opts)
        local conform = require "conform"
        conform.setup(opts)

        -- Create a user command to toggle format_on_save
        vim.api.nvim_create_user_command("FormatToggle", function()
            if vim.g.disable_autoformat then
                vim.g.disable_autoformat = false
                print("Format on save enabled")
            else
                vim.g.disable_autoformat = true
                print("Format on save disabled")
            end
        end, {
            desc = "Toggle format on save",
        })

        -- Modify format_on_save to respect the toggle
        local format_on_save = opts.format_on_save
        opts.format_on_save = function(bufnr)
            if vim.g.disable_autoformat then
                return
            end
            return format_on_save
        end
    end,
}
