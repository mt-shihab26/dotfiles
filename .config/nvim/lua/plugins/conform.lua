local formatters = {
    formatters_by_ft = {
        -- JavaScript
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        astro = { "prettier" },
        vue = { "prettier" },

        -- PHP
        php = { "pint" },
        blade = { "prettier" },

        -- Rust
        rust = { "rustfmt" },

        -- C/C++
        c = { "clang-format" },
        cpp = { "clang-format" },
        cmake = { "cmake_format" },

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
    },
    ignore_install = {
        "pint",

        "cmake_format",
    },
}

return {
    "stevearc/conform.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "zapling/mason-conform.nvim",
    },
    config = function()
        require("conform").setup {
            formatters_by_ft = formatters.formatters_by_ft,
            format_on_save = { timeout_ms = 5000, lsp_format = "fallback" },
        }

        require("mason").setup()

        require("mason-conform").setup {
            ignore_install = formatters.ignore_install,
        }
    end,
}
