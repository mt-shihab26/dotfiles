local map = vim.keymap.set

map("n", "<esc>", "<cmd>nohlsearch<cr>", { desc = "clear search highlighting" })

map("n", "<leader>t", require "utils.toggle_indentation", { desc = "toggle tabs/spaces for indentation" })
