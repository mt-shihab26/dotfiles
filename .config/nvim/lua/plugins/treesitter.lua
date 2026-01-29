return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        lazy = false,
        build = ":TSUpdate",
        opts = {
            ensure_installed = require "lists.parsers",
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true, disable = { "yaml" } },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
    },
    {
        "windwp/nvim-ts-autotag",
        event = { "BufReadPre", "BufNewFile" },
        opts = {},
    },
    {
        "folke/ts-comments.nvim",
        event = "VeryLazy",
    },
}
