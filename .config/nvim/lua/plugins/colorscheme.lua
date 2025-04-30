return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        init = function()
            vim.cmd.colorscheme "tokyonight-night"
        end,
    },
    {
        "NvChad/nvim-colorizer.lua",
        opts = {
            user_default_options = {
                names = false,
                tailwind = true,
            },
        },
    },
}
