return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup {
                ensure_installed = {
                    "lua",
                    "html",
                    "css",
                    "json",
                    "markdown",
                    "markdown_inline",
                    "c",
                    "cpp",
                    "javascript",
                    "typescript",
                    "php",
                    "php_only",
                    "twig",
                    "elixir",
                    "heex",
                    "go",
                    "rust",
                },
                auto_install = true,
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true,
                },
            }

            local parsers = require "nvim-treesitter.parsers"

            parsers.get_parser_configs().blade = {
                install_info = {
                    url = "https://github.com/EmranMR/tree-sitter-blade",
                    files = {
                        "src/parser.c",
                    },
                    branch = "main",
                },
                filetype = "blade",
            }

            vim.filetype.add {
                pattern = {
                    [".*%.blade%.php"] = "blade",
                },
            }
        end,
    },
}
