return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup {}
            -- vim.cmd [[colorscheme catppuccin]] -- catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
        end,
    },
    {
        "zaldih/themery.nvim",
        config = function()
            require("themery").setup {
                themes = {
                    "catppuccin",
                    "catppuccin-latte",
                    "catppuccin-frappe",
                    "catppuccin-macchiato",
                    "catppuccin-mocha",
                },
                livePreview = true,
            }
        end,
    },
}
