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

                -- Sheet
                css = { "prettier" },
                -- sql = { "sqlfmt" },

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

                -- Ruby
                -- ruby = { "rubocop" },

                -- PHP
                php = { "pint" },
                blade = { "prettier" },

                -- Python
                -- python = { "ruff_format" },

                -- Swift
                -- swift = { "swiftformat" },

                -- Java
                -- java = {}, -- TODO

                -- Go
                -- go = { "goimports", "gofmt" },
                -- templ = { "templ" },

                -- Rust
                -- rust = { "rustfmt" },

                -- Zig
                -- zig = { "zigfmt" },

                -- C/C++
                -- c = { "clang-format" },
                -- cpp = { "clang-format" },
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
