return {
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
            vim.cmd [[TailwindFoldDisable]]
        end,
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
