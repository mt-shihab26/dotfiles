return {
    {
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup {
                formatters_by_ft = {
                    lua = { "stylua" },
                    html = { "prettier" },
                    css = { "prettier" },
                    json = { "prettier" },
                    markdown = { "prettier" },
                    c = { "clang-format" },
                    cpp = { "clang-format" },
                    javascript = { "prettier" },
                    javascriptreact = { "prettier" },
                    typescript = { "prettier" },
                    typescriptreact = { "prettier" },
                    astro = { "prettier" },
                    php = { "pint" },
                    blade = { "prettier" },
                    elixir = { "mix" },
                    go = { "goimports", "gofmt" },
                    rust = { "rustfmt", lsp_format = "fallback" },
                },
                format_on_save = {
                    -- These options will be passed to conform.format()
                    timeout_ms = 2000,
                    lsp_format = "fallback",
                },
            }
        end,
    },
}
