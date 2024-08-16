return {
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                php = { "pint" },
                blade = { "prettier" },
                svg = { "prettier" },
                sql = { "sleek" },
                astro = { "prettier" },
            },
        },
    },
}
