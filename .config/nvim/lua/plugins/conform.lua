return {
    "stevearc/conform.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "zapling/mason-conform.nvim",
    },
    config = function()
        local formatters = require "configs.formatters"

        require("conform").setup {
            formatters_by_ft = formatters.formatters_by_ft,
            format_on_save = { timeout_ms = 5000, lsp_format = "fallback" },
        }

        require("mason").setup()

        require("mason-conform").setup {
            ignore_install = formatters.ignore_install,
        }
    end,
}
