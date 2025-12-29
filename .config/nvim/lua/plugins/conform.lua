return {
    "stevearc/conform.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "zapling/mason-conform.nvim",
    },
    config = function()
        require("conform").setup {
            formatters_by_ft = {
                -- Markup
                html = { "prettier" },
                markdown = { "prettier" },
                mdx = { "prettier" },
                svg = { "prettier" },
                json = { "prettier" },
                yaml = { "prettier" },
                toml = { "prettier" },
                css = { "prettier" },
                -- Shell
                sh = { "shfmt" },
                bash = { "shfmt" },
                zsh = { "shfmt" },
                -- Lua
                lua = { "stylua" },
                -- JavaScript
                javascript = { "prettier" },
                javascriptreact = { "prettier" },
                typescript = { "prettier" },
                typescriptreact = { "prettier" },
                vue = { "prettier" },
                astro = { "prettier" },
                -- PHP
                php = { "pint" },
                blade = { "prettier" },
                -- Ruby
                ruby = { "rubocop" },
                -- Python
                python = { "ruff_format" },
                -- Go
                go = { "goimports", "gofmt" },
                templ = { "templ" },
                -- C/C++
                c = { "clang-format" },
                cpp = { "clang-format" },
            },
            format_on_save = { timeout_ms = 5000, lsp_format = "fallback" },
        }
        require("mason").setup()
        require("mason-conform").setup {
            ignore_install = {
                "pint",

                "gofmt",
                "templ",
            },
        }
    end,
}
