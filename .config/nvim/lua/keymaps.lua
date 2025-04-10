-- Search
vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<cr>", { desc = "clear search highlighting" })

-- Clipboard
vim.keymap.set("x", "p", '"_dP', { desc = "paste without yanking selected text", noremap = true })

-- Toggle settings
vim.keymap.set("n", "<leader>t", require "funcs.toggle_indentation", { desc = "toggle tabs/spaces for indentation" })
vim.keymap.set("n", "<leader>w", require "funcs.toggle_wrap", { desc = "toggle line wrapping on/off" })
vim.keymap.set("n", "<leader>c", require "funcs.toogle_copilot", { desc = "toggle copilot on/off" })

-- Source and execute Lua
vim.keymap.set("n", "<space>x", "<cmd>source %<CR>", { desc = "source current file" })
vim.keymap.set("n", "<space>X", ":.lua<CR>", { desc = "execute current line as lua" })
vim.keymap.set("v", "<space>X", ":lua<CR>", { desc = "execute selected text as lua" })
