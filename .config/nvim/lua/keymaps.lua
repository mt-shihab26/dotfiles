-- Search
vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<cr>", { desc = "clear search highlighting" })

-- Clipboard
vim.keymap.set("x", "p", '"_dP', { desc = "paste without yanking selected text", noremap = true })

-- Toggle settings
vim.keymap.set("n", "<leader>t", require "funcs.toggle_indentation", { desc = "toggle tabs/spaces for indentation" })
vim.keymap.set("n", "<leader>W", require "funcs.toggle_wrap", { desc = "toggle line wrapping on/off" })
vim.keymap.set("n", "<leader>c", require "funcs.toogle_copilot", { desc = "toggle copilot on/off" })

-- Source and execute Lua
vim.keymap.set("n", "<space>x", "<cmd>source %<CR>", { desc = "source current file" })
vim.keymap.set("n", "<space>X", ":.lua<CR>", { desc = "execute current line as lua" })
vim.keymap.set("v", "<space>X", ":lua<CR>", { desc = "execute selected text as lua" })

-- Window navigation (for cycling between fugitive and main windows)
vim.keymap.set("n", "<leader>w", "<C-w>w", { desc = "cycle to next window" })
vim.keymap.set("n", "<leader>h", "<C-w>h", { desc = "move to the window on the left" })
vim.keymap.set("n", "<leader>j", "<C-w>j", { desc = "move to the window below" })
vim.keymap.set("n", "<leader>k", "<C-w>k", { desc = "move to the window above" })
vim.keymap.set("n", "<leader>l", "<C-w>l", { desc = "move to the window on the right" })
