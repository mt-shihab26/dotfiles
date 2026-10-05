vim.pack.add {
    {
        src = "https://github.com/lewis6991/gitsigns.nvim",
        version = "main",
    },
}

local gitsigns = require "gitsigns"

gitsigns.setup {
    preview_config = {
        border = { "", "", "", " " },
    },
    current_line_blame = true,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 1000,
        ignore_whitespace = false,
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
