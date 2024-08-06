return {
    {
        "folke/tokyonight.nvim",
        config = function()
            require("tokyonight").setup {}
        end,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        config = function()
            require("catppuccin").setup {}
        end,
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require("rose-pine").setup {}
        end,
    },
    {
        "0xstepit/flow.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            require("flow").setup {
                transparent = true,
                fluo_color = "pink", --  pink, yellow, orange, green
                mode = "normal", -- normal, bright, desaturate, dark
                aggressive_spell = false,
            }
        end,
    },
    {
        "Mofiqul/dracula.nvim",
        config = function()
            require("catppuccin").setup {}
        end,
    },
    {
        "zaldih/themery.nvim",
        config = function()
            require("themery").setup {
                themes = {
                    "tokyonight",
                    "tokyonight-night",
                    "tokyonight-storm",
                    "tokyonight-day",
                    "tokyonight-moon",
                    "catppuccin",
                    "catppuccin-latte",
                    "catppuccin-frappe",
                    "catppuccin-macchiato",
                    "catppuccin-mocha",
                    "rose-pine-main",
                    "rose-pine-moon",
                    "rose-pine-dawn",
                    "flow",
                    "dracula",
                    "dracula-soft",
                },
                livePreview = true,
            }
        end,
    },
}
