vim.g.mapleader = " " -- Sets the leader key to Space for custom keybindings
vim.g.maplocalleader = "\\" -- Sets the local leader key to backslash for buffer-local mappings

vim.opt.number = true -- Shows absolute line numbers
vim.opt.relativenumber = true -- Shows relative line numbers for easier jumping

vim.opt.tabstop = 4 -- Sets the width of a tab character to 4 spaces
vim.opt.shiftwidth = 4 -- Sets the width of indentation to 4 spaces
vim.opt.expandtab = true -- Converts tabs to spaces
vim.opt.autoindent = true -- Copies indentation from previous line when starting a new line

vim.opt.clipboard = "unnamedplus" -- Uses system clipboard for copy/paste operations

vim.opt.mouse = "a" -- Enables mouse support in all modes

vim.opt.breakindent = true -- Maintains indent level when wrapping long lines

vim.opt.undofile = true -- Enables persistent undo history

vim.opt.ignorecase = true -- Makes search case-insensitive
vim.opt.smartcase = true -- Makes search case-sensitive when using uppercase
