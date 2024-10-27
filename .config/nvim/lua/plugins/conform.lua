return {
    "stevearc/conform.nvim",
    opts = {
        format_on_save = {
            -- These options will be passed to conform.format()
            timeout_ms = 1000,
            -- lsp_format = "fallback",
        },
        formatters_by_ft = {
            -- tools
            svg = { "prettier" },
            yaml = { "prettier" },
            json = { "prettier" },
            jsonc = { "prettier" },
            fish = { "fish_indent" },
            sh = { "shfmt" },

            -- lua
            lua = { "stylua" },

            -- markdown
            markdown = { "prettier" },
            mdx = { "prettier" },

            -- css
            html = { "prettier" },
            css = { "prettier" },
            scss = { "prettier" },
            less = { "prettier" },

            -- javascript
            javascript = { "prettier" },
            javascriptreact = { "prettier" },
            typescript = { "prettier" },
            typescriptreact = { "prettier" },
            astro = { "prettier" },
            vue = { "prettier" },

            -- php
            php = { "pint" },
            blade = { "prettier" },

            -- go
            go = { "goimports", "gofumpt" },
            templ = { "templ" },
        },
    },
}
