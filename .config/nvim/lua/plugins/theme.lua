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
    {
        src = "https://github.com/xiyaowong/transparent.nvim",
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

require("transparent").setup {
    groups = {
        "Normal",
        "NormalNC",
        "NeoTreeNormal",
        "NeoTreeNormalNC",
        "TelescopeNormal",
        "TelescopeBorder",
        "TelescopePromptNormal",
        "TelescopePromptBorder",
        "TelescopePromptTitle",
        "TelescopePreviewTitle",
        "TelescopeResultsTitle",
        "TelescopePreviewNormal",
        "TelescopePreviewBorder",
        "TelescopeResultsNormal",
        "TelescopeResultsBorder",
        "TelescopeMatching",
    },
    extra_groups = {},
    exclude_groups = {},
    on_clear = function() end,
}

vim.cmd "TransparentEnable"
