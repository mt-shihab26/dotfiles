vim.pack.add { "https://github.com/folke/snacks.nvim" }

local snacks = require "snacks"

-- Opening an image file renders it in the buffer via the kitty graphics protocol
snacks.setup {
    image = { enabled = true },
}
