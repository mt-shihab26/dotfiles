return {
    {
        "rcarriga/nvim-notify",
        enabled = false,
    },
    {
        "folke/noice.nvim",
        enabled = false,
    },
    {
        "nvim-telescope/telescope.nvim",
        opts = {
            defaults = {
                layout_strategy = "horizontal",
                layout_config = { prompt_position = "top" },
                sorting_strategy = "ascending",
                winblend = 0,
            },
        },
    },
    {
        "razak17/tailwind-fold.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        event = "VeryLazy",
        config = function()
            require("tailwind-fold").setup {
                ft = {
                    "html",
                    "astro",
                    "vue",
                    "typescriptreact",
                    "javascriptreact",
                    "php",
                    "blade",
                },
            }
            -- vim.cmd [[TailwindFoldDisable]]
        end,
    },
    {
        "kdheepak/lazygit.nvim",
        event = "VeryLazy",
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require("toggleterm").setup {
                direction = "float",
            }
        end,
    },
}
