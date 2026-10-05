vim.pack.add {
    {
        src = "https://github.com/folke/snacks.nvim",
        version = vim.version.range "2",
    },
}

local snacks = require "snacks"
local image = require "lib.image"

-- Opening an image file renders it in the buffer via the kitty graphics protocol
snacks.setup {
    image = { enabled = true },
}

image.setup(snacks.image)
