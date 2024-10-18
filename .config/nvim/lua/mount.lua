-- Set tab width to 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Enable line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse support
vim.opt.mouse = "a"

-- Set minimum number of screen lines above and below the cursor
vim.opt.scrolloff = 8

-- Highlight the line where the cursor is
vim.opt.cursorline = true

-- Show matching brackets
vim.opt.showmatch = true

-- Enable system clipboard integration
vim.opt.clipboard = "unnamedplus"

-- Enable persistent undo
vim.opt.undofile = true

-- Enable 24-bit RGB color in the terminal
vim.opt.termguicolors = true

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- File type detection for .env and .env.example files
vim.cmd [[
  augroup dotenv
    autocmd!
    autocmd BufNewFile,BufRead .env,.env.* setfiletype sh
    autocmd BufNewFile,BufRead .env.example setfiletype sh
  augroup END
]]
