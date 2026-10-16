local lazy = require "lib.lazy"

-- loads right after startup
lazy.add({
    {
        src = "https://github.com/folke/which-key.nvim",
        version = vim.version.range "3",
    },
}, {
    modules = { "which-key" },
    defer = true,
    setup = function()
        require("which-key").setup {}
    end,
})
