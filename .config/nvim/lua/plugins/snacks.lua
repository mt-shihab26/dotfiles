vim.pack.add {
    {
        src = "https://github.com/folke/snacks.nvim",
        version = vim.version.range "2",
    },
}

local snacks = require "snacks"
local image = require "lib.image"

-- image: opening an image file renders it in the buffer via the kitty graphics protocol. Small
-- images are scaled up with -sample (nearest neighbor, sharp pixels) before the terminal scales
-- them smoothly, and large ones are scaled down as before.
-- bigfile: files over 1.5MB or with very long lines (minified) get the "bigfile" filetype, so treesitter, language servers, completion, indent guides and color highlighting stay off and the file opens fast
snacks.setup {
    image = {
        enabled = true,
        convert = {
            magick = {
                default = { "{src}[0]", "-sample", "1920x1080<", "-scale", "1920x1080>" },
            },
        },
    },
    bigfile = { enabled = true },
}

image.setup(snacks.image)
