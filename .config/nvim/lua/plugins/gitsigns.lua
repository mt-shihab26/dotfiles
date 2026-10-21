local lazy = require "lib.lazy"

-- loads right after startup, its setup attaches to the buffers already open
lazy.add({
    {
        src = "https://github.com/lewis6991/gitsigns.nvim",
        version = "main",
    },
}, {
    modules = { "gitsigns" },
    commands = { "Gitsigns" },
    defer = true,
    setup = function()
        local gitsigns = require "gitsigns"

        gitsigns.setup {
            preview_config = {
                border = { "", "", "", " " },
            },
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "┄" },
                untracked = { text = "┆" },
            },
            signs_staged = {
                add = { text = "│" },
                change = { text = "≈" },
                delete = { text = "▁" },
                topdelete = { text = "▔" },
                changedelete = { text = "┈" },
                untracked = { text = "║" },
            },
        }
    end,
})
