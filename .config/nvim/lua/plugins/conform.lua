-- Formatting

return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            -- tools
            lua = { "stylua" },
            sh = { "shfmt" },
            fish = { "fish_indent" },
            svg = { "prettier" },
            json = { "prettier" },
            jsonc = { "prettier" },
            yaml = { "prettier" },
            markdown = { "prettier" },
            mdx = { "prettier" },
            graphql = { "prettier" },

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
