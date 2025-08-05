vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<cr>", { desc = "clear search highlighting" })

vim.keymap.set("x", "p", '"_dP', { desc = "paste without yanking selected text", noremap = true })

vim.keymap.set("n", "<leader>x", "<cmd>CFExe<cr>", { desc = "execute current file based on language of cp" })

-- moving around nvim windows
vim.keymap.set("n", "<leader>h", "<C-w>h", { desc = "move to left window", noremap = true, silent = true })
vim.keymap.set("n", "<leader>j", "<C-w>j", { desc = "move to below window", noremap = true, silent = true })
vim.keymap.set("n", "<leader>k", "<C-w>k", { desc = "move to above window", noremap = true, silent = true })
vim.keymap.set("n", "<leader>l", "<C-w>l", { desc = "move to right window", noremap = true, silent = true })

-- toggle things
vim.keymap.set("n", "<leader>ti", "<cmd>ToggleIndenChar<cr>", { desc = "toggle tabs/spaces for indentation" })
vim.keymap.set("n", "<leader>tw", "<cmd>ToggleWrap<cr>", { desc = "toggle line wrapping on/off" })
vim.keymap.set("n", "<leader>tc", "<cmd>ToggleCopilot<cr>", { desc = "toggle gitHub copilot on/off" })
