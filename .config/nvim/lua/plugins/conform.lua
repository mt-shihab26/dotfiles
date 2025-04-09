return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
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

            -- swift
            swift = { "swiftformat" },

            -- rust
            rust = { "rustfmt" },

            -- zig
            zig = { "zigfmt" },

            -- c/c++
            c = { "clang-format" },
            cpp = { "clang-format" },
            cmake = { "cmake_format" },
        },
        format_on_save = {
            timeout_ms = 5000,
            lsp_format = "fallback",
        },
    },
}
