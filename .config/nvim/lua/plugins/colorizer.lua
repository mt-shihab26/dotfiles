vim.pack.add {
    {
        src = "https://github.com/NvChad/nvim-colorizer.lua",
    },
    {
        src = "https://github.com/lukas-reineke/indent-blankline.nvim",
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
