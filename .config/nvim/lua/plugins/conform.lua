-- Formatting

return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            svg = { "prettier" },
            markdown = { "prettier" },

            -- php
            php = { "pint" },
            blade = { "prettier" },

            -- go
            go = { "goimports", "gofumpt" },
            templ = { "templ" },
        },
    },
}
