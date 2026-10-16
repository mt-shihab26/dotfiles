vim.pack.add {
    {
        src = "https://github.com/folke/snacks.nvim",
        version = vim.version.range "2",
    },
}

local snacks = require "snacks"
local image = require "lib.image"

-- image: opening an image file renders it in the buffer via the kitty graphics protocol
-- bigfile: files over 1.5MB or with very long lines (minified) get the "bigfile" filetype, so treesitter, language servers, completion, indent guides and color highlighting stay off and the file opens fast
snacks.setup {
    image = { enabled = true },
    bigfile = { enabled = true },
}

image.setup(snacks.image)
