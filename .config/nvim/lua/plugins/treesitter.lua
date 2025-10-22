local mdx_support = function()
    -- Register the mdx filetype
    vim.filetype.add { extension = { mdx = "mdx" } }

    -- Configure treesitter to use the markdown parser for mdx files
    vim.treesitter.language.register("markdown", "mdx")

    -- If the current buffer has the extension mdx, but not the newly create filetype, set it
    if vim.endswith(vim.api.nvim_buf_get_name(0), ".mdx") and vim.o.filetype ~= "mdx" then
        vim.o.filetype = "mdx"
    end
end

return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = "VeryLazy",
        build = function()
            require("nvim-treesitter.install").update { with_sync = true }
        end,
        opts = {
            ensure_installed = {
                -- Markup
                "html",
                "xml",
                "markdown",
                "markdown_inline",
                "json",
                "jsonc",
                "yaml",
                "toml",
                "dockerfile",
                "diff",
                "git_config",
                "gitcommit",
                "git_rebase",
                "gitignore",
                "gitattributes",

                -- Sheet
                "css",

                -- Shell
                "bash",

                -- Lua
                "lua",
                "luadoc",
                "luap",
                "vimdoc",
                "vim",

                -- JavaScript
                "javascript",
                "jsdoc",
                "typescript",
                "tsx",
                "astro",
                "vue",

                -- Ruby
                -- "ruby",
                -- "embedded_template",

                -- PHP
                "php",
                "php_only",
                "twig",

                -- Python
                -- "python",

                -- Java
                -- "java",
                -- "kotlin",
                -- "gradle", -- Parser not available

                -- Elixir
                -- "elixir",
                -- "heex",
                -- "eex",

                -- Go
                -- "go",
                -- "gomod",
                -- "gowork",
                -- "gosum",
                -- "templ",

                -- Rust
                -- "rust",

                -- Zig
                -- "zig",

                -- C/C++
                -- "c",
                -- "cpp",
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

            mdx_support()

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
