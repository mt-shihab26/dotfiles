local ensure_installed = {
    "c",
    "diff",
    "vim",
    "vimdoc",
    "printf",
    "python",
    "query",
    "regex",

    -- tools
    "xml",
    "toml",
    "yaml",
    "bash",

    -- lua
    "lua",
    "luadoc",
    "luap",

    -- markdown
    "markdown",
    "markdown_inline",

    -- git
    "git_config",
    "gitcommit",
    "git_rebase",
    "gitignore",
    "gitattributes",

    -- docker
    "dockerfile",

    -- css
    "html",
    "css",

    -- javascript
    "javascript",
    "jsdoc",
    "json",
    "jsonc",
    "typescript",
    "tsx",
    "astro",
    "vue",

    -- php
    "php",
    "php_only",
    "twig",

    -- go
    "go",
    "gomod",
    "gowork",
    "gosum",
    "templ",
}

return {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = function()
        require("nvim-treesitter.install").update { with_sync = true }
    end,
    opts = {
        ensure_installed = ensure_installed,
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true, disable = { "yaml" } },
        rainbow = { enable = true },
    },
    config = function(_, opts)
        local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

        parser_config.blade = {
            install_info = {
                url = "https://github.com/EmranMR/tree-sitter-blade",
                files = { "src/parser.c" },
                branch = "main",
            },
            filetype = "blade",
        }

        vim.filetype.add {
            pattern = {
                [".*%.blade%.php"] = "blade",
            },
        }

        require("nvim-treesitter.configs").setup(opts)
    end,
}
