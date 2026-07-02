vim.pack.add {
    {
        src = "https://github.com/folke/tokyonight.nvim",
        version = vim.version.range "4",
    },
    {
        src = "https://github.com/NvChad/nvim-colorizer.lua",
    },
    {
        src = "https://github.com/lukas-reineke/indent-blankline.nvim",
    },
}

require("colorizer").setup {
    user_default_options = {
        names = false,
        tailwind = true,
    },
}

require("tokyonight").setup {}

vim.cmd.colorscheme "tokyonight-night"

require("ibl").setup {
    scope = { show_start = false },
    exclude = { filetypes = { "dashboard" } },
}
