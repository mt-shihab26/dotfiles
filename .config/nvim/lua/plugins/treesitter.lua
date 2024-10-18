return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup {
            ensure_installed = {
                "c",
                "diff",
                "printf",
                "python",
                "query",
                "regex",
                "lua",
                "luadoc",
                "luap",
                "vim",
                "vimdoc",
                "markdown",
                "markdown_inline",
                "xml",
                "toml",
                "yaml",
                "bash",

                -- javascript
                "html",
                "css",
                "scss",
                "javascript",
                "jsdoc",
                "json",
                "jsonc",
                "tsx",
                "typescript",
                "vue",
                "astro",
                "svelte",

                -- php
                "php",
                "php_only",
                "twig",

                -- go
                "go",
                "templ",

                -- elixir
                "elixir",
                "heex",
            },
            auto_install = true,
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        }

        -- blade parser
        vim.filetype.add {
            pattern = {
                [".*%.blade%.php"] = "blade",
            },
        }
        require("nvim-treesitter.parsers").get_parser_configs().blade = {
            install_info = {
                url = "https://github.com/EmranMR/tree-sitter-blade",
                files = {
                    "src/parser.c",
                },
                branch = "main",
            },
            filetype = "blade",
        }
    end,
}
