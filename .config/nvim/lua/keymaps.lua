local map = vim.keymap.set

-- Clear search highlights with Esc
map("n", "<esc>", "<cmd>nohlsearch<cr>", { desc = "clear search highlighting" })

-- Toggle between tabs/spaces
map("n", "<leader>t", require "utils.toggle_indentation", { desc = "toggle tabs/spaces for indentation" })

-- Paste without copying replaced text
map("x", "p", '"_dP', { noremap = true, desc = "paste without yanking selected text" })

-- Comment keymaps
map("n", "<leader>/", "gcc", { desc = "toggle comment line" })
map("v", "<leader>/", "gc", { desc = "toggle comment selection" })
map("o", "<leader>/", "gc", { desc = "toggle comment selection" })
