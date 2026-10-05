vim.pack.add {
    {
        src = "https://github.com/NvChad/nvim-colorizer.lua",
        version = "master",
    },
    {
        src = "https://github.com/lukas-reineke/indent-blankline.nvim",
        version = vim.version.range "3",
    },
}

local colorizer = require "colorizer"
local ibl = require "ibl"

colorizer.setup {
    user_default_options = {
        names = false,
        tailwind = true,
    },
}

ibl.setup {
    scope = { show_start = false },
    exclude = { filetypes = { "dashboard" } },
}
