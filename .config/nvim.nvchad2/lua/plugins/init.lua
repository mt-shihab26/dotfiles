return {
    {
        "stevearc/conform.nvim",
        -- event = 'BufWritePre', -- uncomment for format on save
        opts = {},
    },

    -- These are some examples, uncomment them if you want to see them work!
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "configs.lspconfig"
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "lua",
                "html",
                "css",
                "json",
                "markdown",
                "c",
                "cpp",
                "javascript",
                "typescript",
                "php",
                "php_only",
                "twig",
                "elixir",
                "go",
                "rust",
            },
            auto_install = true,
        },
    },
    {
        "NvChad/nvim-colorizer.lua",
        opts = {
            user_default_options = {
                tailwind = true,
            },
        },
    },
    {
        "windwp/nvim-ts-autotag",
        ft = {
            "html",
            "php",
            "blade",
            "twig",
            "javascriptreact",
            "typescriptreact",
        },
        config = function()
            require("nvim-ts-autotag").setup {}
        end,
    },
}
