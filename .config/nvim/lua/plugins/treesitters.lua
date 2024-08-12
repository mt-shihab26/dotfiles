return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            "terrortylor/nvim-comment",
            "nvim-treesitter/nvim-treesitter-textobjects",
            "nvim-treesitter/playground",
        },
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
                highlight = { enable = true },
                indent = { enable = true, disable = { "yaml" } },
                context_commentstring = { enable = true },
                rainbow = { enable = true },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["if"] = "@function.inner",
                            ["af"] = "@function.outer",
                            ["ia"] = "@parameter.inner",
                            ["aa"] = "@parameter.outer",
                        },
                    },
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
