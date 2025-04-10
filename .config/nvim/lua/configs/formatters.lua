return {
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

        ruby = { "rubocop" },

        python = { "ruff" },

        go = { "goimports", "gofmt" },
        templ = { "templ" },

        swift = { "swiftformat" },

        rust = { "rustfmt" },

        zig = { "zigfmt" },

        c = { "clang-format" },
        cpp = { "clang-format" },
        cmake = { "cmake_format" },
    },
    ignore_install = {
        "gofmt",
        "templ",

        "swiftformat",

        "zigfmt",

        "cmake_format",
    },
}
