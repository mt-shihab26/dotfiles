-- moving around nvim windows 
vim.keymap.set('n', '<leader>h', '<C-w>h', { desc = "move to left window", noremap = true, silent = true })
vim.keymap.set('n', '<leader>j', '<C-w>j', { desc = "move to below window", noremap = true, silent = true })
vim.keymap.set('n', '<leader>k', '<C-w>k', { desc = "move to above window", noremap = true, silent = true })
vim.keymap.set('n', '<leader>l', '<C-w>l', { desc = "move to right window", noremap = true, silent = true })

