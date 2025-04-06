vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.number = true
vim.opt.relativenumber = true

vim.schedule(function()
    vim.opt.clipboard = "unnamedplus"
end)

vim.opt.mouse = "a"

vim.opt.breakindent = true

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.spelllang = "en_us"
vim.opt.spell = true

vim.opt.list = true
vim.opt.listchars = { space = "·", trail = "·", tab = "→ ", eol = "↲", nbsp = "␣" }

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true

vim.opt.swapfile = false

vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 10

vim.wo.wrap = false

vim.opt.guicursor = ""
vim.opt.guicursor = "n-v-c:block-blinkwait700-blinkoff400-blinkon250,i-ci-ve:block-blinkwait700-blinkoff400-blinkon250"
