local map = vim.keymap.set

-- Clear search highlights with Esc
map("n", "<esc>", "<cmd>nohlsearch<cr>", { desc = "clear search highlighting" })

-- Paste without copying replaced text
map("x", "p", '"_dP', { desc = "paste without yanking selected text", noremap = true })

-- Toggle between tabs/spaces
map("n", "<leader>t", require "lib.toggle_indentation", { desc = "toggle tabs/spaces for indentation" })

-- Toggle line wrapping
map("n", "<leader>w", require "lib.toggle_wrap", { desc = "toggle line wrapping on/off" })

-- Source the current file
map("n", "<space>x", "<cmd>source %<CR>", { desc = "source current file" })

-- Execute current line as Lua code
map("n", "<space>X", ":.lua<CR>", { desc = "execute current line as lua" })

-- Execute selected text as Lua code
map("v", "<space>X", ":lua<CR>", { desc = "execute selected text as lua" })
