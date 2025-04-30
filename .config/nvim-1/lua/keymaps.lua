-- Search
vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<cr>", { desc = "clear search highlighting" })

-- Clipboard
vim.keymap.set("x", "p", '"_dP', { desc = "paste without yanking selected text", noremap = true })

-- Toggle
vim.keymap.set("n", "<leader>ti", require "funcs.toggle_indentation", { desc = "toggle tabs/spaces for indentation" })
vim.keymap.set("n", "<leader>tw", require "funcs.toggle_wrap", { desc = "toggle line wrapping on/off" })
vim.keymap.set("n", "<leader>tc", require "funcs.toogle_copilot", { desc = "toggle gitHub copilot on/off" })
