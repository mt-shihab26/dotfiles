-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local wk = require "which-key"

wk.add {
    { "<leader>k", vim.diagnostic.open_float, mode = "n", desc = "Hover Diagnostics" },

    -- tabs
    { "<leader>bc", "<CMD>bp<bar>sp<bar>bn<bar>bd<CR>", mode = "n", desc = "close buffer" },

    -- integrations
    { "<leader>o", group = "open things" },
    { "<leader>od", "<CMD>LazyDocker<CR>", mode = "n", desc = "open lazydocker" },
    { "<leader>os", "<CMD>LazySQL<CR>", mode = "n", desc = "open lazysql" },
    { "<leader>ol", "<CMD>OpenInBrowser<CR>", mode = { "n", "v" }, desc = "open in browser" },
    { "<leader>ot", "<CMD>Themery<CR>", mode = "n", desc = "open colorscheme changer" },
}
