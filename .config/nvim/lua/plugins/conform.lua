return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = require "configs.conform_formatters",
        format_on_save = {
            timeout_ms = 5000,
            -- lsp_format = "fallback",
        },
    },
}
