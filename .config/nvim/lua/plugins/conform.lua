return {
    "stevearc/conform.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "zapling/mason-conform.nvim",
    },
    config = function()
        require("conform").setup {
            formatters_by_ft = {
                -- JavaScript
                javascript = { "prettier" },
                javascriptreact = { "prettier" },
                typescript = { "prettier" },
                typescriptreact = { "prettier" },
                astro = { "prettier" },
                vue = { "prettier" },
                -- Ruby
                ruby = { "rubocop" },
                -- PHP
                php = { "pint" },
                blade = { "prettier" },
                -- Python
                python = { "ruff" },
                -- Java
                -- java = {}, -- TODO
                -- Go
                go = { "goimports", "gofmt" },
                templ = { "templ" },
                -- Rust
                rust = { "rustfmt" },
                -- C/C++
                c = { "clang-format" },
                cpp = { "clang-format" },
                -- Others
                lua = { "stylua" },
                sh = { "shfmt" },
                bash = { "shfmt" },
                zsh = { "shfmt" },
                sql = { "sqlfmt" },
                html = { "prettier" },
                markdown = { "prettier" },
                mdx = { "prettier" },
                svg = { "prettier" },
                css = { "prettier" },
                json = { "prettier" },
                yaml = { "prettier" },
                toml = { "prettier" },
                -- swift = { "swiftformat" },
                -- zig = { "zigfmt" },
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
