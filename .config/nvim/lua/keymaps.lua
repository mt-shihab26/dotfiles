local map = vim.keymap.set

-- Clear search highlights with Esc
map("n", "<esc>", "<cmd>nohlsearch<cr>", { desc = "clear search highlighting" })

-- Toggle between tabs/spaces
map("n", "<leader>t", require "utils.toggle_indentation", { desc = "toggle tabs/spaces for indentation" })

-- Paste without copying replaced text
map("x", "p", '"_dP', { noremap = true, desc = "paste without yanking selected text" })
