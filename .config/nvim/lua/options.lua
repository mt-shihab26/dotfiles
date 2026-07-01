vim.opt.number = true -- line numbering
vim.opt.relativenumber = true

vim.opt.cursorline = true -- highlight the current line

vim.opt.list = true -- show invisible characters
vim.opt.signcolumn = "yes"
vim.opt.listchars = { space = "·", trail = "·", tab = "→ ", eol = "↲", nbsp = "␣" }

vim.wo.wrap = false -- don't wrap lines

vim.opt.mouse = "a" -- enable mouse in all modes
vim.opt.undofile = true -- Enable persistent undo history
vim.opt.swapfile = false -- Disable swap files

vim.opt.spell = true -- enable spell checking
vim.opt.spelllang = "en_us"

vim.opt.tabstop = 4 -- indentation settings
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.breakindent = true

vim.opt.splitright = true -- open new vertical splits to the right
vim.opt.splitbelow = true -- open new horizontal splits below

vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.smartcase = true -- override ignorecase if search contains uppercase
vim.opt.inccommand = "split" -- show preview of substitutions in a split

vim.opt.updatetime = 250 -- faster completion and other operations
vim.opt.timeoutlen = 300 -- time to wait for a mapped sequence to complete

-- use system clipboard
vim.schedule(function()
    vim.opt.clipboard = "unnamedplus"
end)

-- file type detection for .env and .env.* files
vim.cmd [[
  augroup dotenv
    autocmd!
    autocmd BufNewFile,BufRead .env,.env.* setfiletype sh
  augroup END
]]
