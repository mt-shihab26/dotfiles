return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = "VeryLazy",
        build = function()
            require("nvim-treesitter.install").update { with_sync = true }
        end,
        opts = {
            ensure_installed = {
                -- JavaScript
                "javascript",
                "jsdoc",
                "typescript",
                "tsx",
                "astro",
                "vue",

                -- Ruby
                "ruby",
                "embedded_template",

                -- PHP
                "php",
                "php_only",
                "twig",

                -- Python
                "python",

                -- Java
                "java",
                "kotlin",
                "gradle",

                -- Go
                "go",
                "gomod",
                "gowork",
                "gosum",
                "templ",

                -- Rust
                "rust",

                -- C/C++
                "c",
                "cpp",

                -- Others
                "lua",
                "luadoc",
                "luap",
                "html",
                "xml",
                "markdown",
                "markdown_inline",
                "css",
                "json",
                "jsonc",
                "yaml",
                "toml",
                "vimdoc",
                "vim",
                "bash",
                "dockerfile",
                "diff",
                "git_config",
                "gitcommit",
                "git_rebase",
                "gitignore",
                "gitattributes",

                -- "elixir",
                -- "heex",
                -- "eex",
                -- "zig",
            },
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

            parser_config.ejs = {
                install_info = {
                    url = "https://github.com/tree-sitter/tree-sitter-embedded-template",
                    files = { "src/parser.c" },
                    branch = "main",
                },
                filetype = "ejs",
            }

            vim.filetype.add {
                pattern = {
                    [".*%.blade%.php"] = "blade",
                },
            }

            vim.filetype.add {
                pattern = {
                    [".*%.ejs"] = "blade",
                },
            }

            require("nvim-treesitter.configs").setup(opts)
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        event = "VeryLazy",
        ft = {
            "html",
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
            "svelte",
            "vue",
            "tsx",
            "jsx",
            "rescript",
            "xml",
            "php",
            "markdown",
            "astro",
            "glimmer",
            "handlebars",
            "hbs",
        },
        opts = {},
    },
    {
        "folke/ts-comments.nvim",
        opts = {},
        event = "VeryLazy",
        enabled = vim.fn.has "nvim-0.10.0" == 1,
    },
}
