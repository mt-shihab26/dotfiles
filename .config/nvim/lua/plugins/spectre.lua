vim.pack.add {
    {
        src = "https://github.com/nvim-pack/nvim-spectre",
        version = "master",
    },
}

local spectre = require "spectre"

spectre.setup {}
