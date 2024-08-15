-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local wk = require "which-key"

wk.add {
    { "<leader>k", vim.diagnostic.open_float, mode = "n", desc = "Hover Diagnostics" },
    { "<leader>nn", "<CMD>GoIfErr<CR>", mode = "n", desc = "Generate if err != nil {" },
    { "<leader>gac", "<CMD>GoTagAdd json<CR>", mode = "n", desc = "Add and remove tags for structs" },
}
