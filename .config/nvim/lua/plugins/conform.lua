return {
    "stevearc/conform.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "zapling/mason-conform.nvim",
    },
    config = function()
        require("conform").setup {
            formatters_by_ft = require "configs.formatters",
            format_on_save = { timeout_ms = 5000, lsp_format = "fallback" },
        }

        require("mason").setup()

        require("mason-conform").setup {
            ignore_install = {},
        }
    end,
}
