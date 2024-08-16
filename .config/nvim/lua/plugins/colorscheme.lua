return {
    -- {
    --     "LazyVim/LazyVim",
    --     opts = {
    --         -- colorscheme = "gatekeeper",
    --     },
    -- },
    {
        "zaldih/themery.nvim",
        config = function()
            require("themery").setup {
                themes = require "config.themes",
                livePreview = true,
            }
        end,
    },
}
