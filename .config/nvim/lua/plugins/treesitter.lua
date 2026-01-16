return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        lazy = false,
        build = ":TSUpdate",
        opts = {
            ensure_installed = require "lists.treesitter",
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true, disable = { "yaml" } },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        event = "VeryLazy",
        ft = require "lists.autotag",
    },
    {
        "folke/ts-comments.nvim",
        event = "VeryLazy",
        enabled = vim.fn.has "nvim-0.10.0" == 1,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
    },
}
