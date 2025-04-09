return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            html = { "prettier" },
            markdown = { "prettier" },
            mdx = { "prettier" },
            svg = { "prettier" },
            css = { "prettier" },
            scss = { "prettier" },
            less = { "prettier" },
            json = { "prettier" },
            jsonc = { "prettier" },
            yaml = { "prettier" },

            javascript = { "prettier" },
            javascriptreact = { "prettier" },
            typescript = { "prettier" },
            typescriptreact = { "prettier" },
            astro = { "prettier" },
            vue = { "prettier" },

            php = { "pint" },
            blade = { "prettier" },

            ruby = { "rubyfmt" },

            python = { "ruff" },

            go = { "goimports", "gofmt" },
            templ = { "templ" },

            rust = { "rustfmt" },
        },
        format_on_save = {
            timeout_ms = 5000,
            lsp_format = "fallback",
        },
    },
}
