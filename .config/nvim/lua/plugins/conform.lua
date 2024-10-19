-- Formatting

return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            svg = { "prettier" },
            markdown = { "prettier" },
            templ = { "templ" },

            -- php
            php = { "pint" },
            blade = { "prettier" },
        },
    },
}
