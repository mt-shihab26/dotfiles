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
                -- PHP
                "php",
                "php_only",
                "blade",
                "twig",
                -- Ruby
                "ruby",
                "embedded_template",
                -- Python
                "python",
                -- Go
                "go",
                "gomod",
                "gowork",
                "gosum",
                "templ",
                -- C/C++
                "c",
                "cpp",
            },
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true, disable = { "yaml" } },
            rainbow = { enable = true },
        },
        config = function(_, opts)
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
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            scope = {
                show_start = false,
            },
            exclude = {
                filetypes = {
                    "dashboard",
                },
            },
        },
    },
}
