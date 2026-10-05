vim.pack.add {
    {
        src = "https://github.com/folke/which-key.nvim",
        version = vim.version.range "3",
    },
}

local which_key = require "which-key"

which_key.setup {}
