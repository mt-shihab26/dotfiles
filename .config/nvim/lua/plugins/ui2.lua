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
    {
        "nvimdev/dashboard-nvim",
        opts = {
            theme = "hyper",
            config = {
                week_header = {
                    enable = true,
                },
                shortcut = {
                    {
                        action = "Lazy",
                        desc = " Lazy",
                        icon = "󰒲 ",
                        key = "l",
                        group = "Label",
                    },
                    {
                        action = "Mason",
                        desc = "Mason",
                        icon = " ",
                        key = "m",
                        group = "@property",
                    },
                    {
                        action = "lua LazyVim.pick.config_files()()",
                        desc = " Config",
                        icon = " ",
                        key = "c",
                        group = "@property",
                    },
                    {
                        action = function()
                            vim.api.nvim_input "<cmd>qa<cr>"
                        end,
                        desc = " Quit",
                        icon = " ",
                        key = "q",
                        group = "Label",
                    },
                },
            },
        },
    },
}
