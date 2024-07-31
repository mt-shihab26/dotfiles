local options = {
    formatters_by_ft = {
        lua = { "stylua" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        vue = { "prettier" },
        php = { "pint" },
    },

    format_on_save = {
        timeout_ms = 2000,
        lsp_fallback = true,
    },
}

require("conform").setup(options)
