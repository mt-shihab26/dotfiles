vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<cr>", { desc = "clear search highlighting", noremap = true })
vim.keymap.set("n", "q", "<nop>", { desc = "disabled macro recording", noremap = true })
vim.keymap.set("x", "p", '"_dP', { desc = "paste without yanking selected text", noremap = true })

vim.keymap.set("n", "<leader>h", "<C-w>h", { desc = "move to left window", noremap = true, silent = true })
vim.keymap.set("n", "<leader>j", "<C-w>j", { desc = "move to below window", noremap = true, silent = true })
vim.keymap.set("n", "<leader>k", "<C-w>k", { desc = "move to above window", noremap = true, silent = true })
vim.keymap.set("n", "<leader>l", "<C-w>l", { desc = "move to right window", noremap = true, silent = true })

vim.keymap.set("n", "l", require "utils.open_last_file", { desc = "open last file or move right", noremap = true })
vim.keymap.set("n", "<leader>ti", require "utils.toggle_indent_char", { desc = "toggle tabs/spaces for indentation" })
vim.keymap.set("n", "<leader>tw", require "utils.toggle_wrap", { desc = "toggle line wrapping on/off" })

vim.keymap.set("n", "<leader>cp", require "utils.copy_file_path", { desc = "copy current file relative path" })
vim.keymap.set("n", "<leader>ca", require "utils.copy_file_abs_path", { desc = "copy current file absolute path" })
vim.keymap.set("n", "<leader>cf", require "utils.copy_file_name", { desc = "copy current file name with extension" })
vim.keymap.set("n", "<leader>w", require "utils.wip", { desc = "git wip commit and push" })
