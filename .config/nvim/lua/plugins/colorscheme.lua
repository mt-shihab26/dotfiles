return {
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
                    "abscs",
                    "material",
                    "oxocarbon",
                },
                livePreview = true,
            }
        end,
    },
    {
        "Abstract-IDE/Abstract-cs",
    },
    {
        "marko-cerovac/material.nvim",
    },
    {
        "nyoom-engineering/oxocarbon.nvim",
    },
}
