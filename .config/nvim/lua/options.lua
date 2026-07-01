vim.g.netrw_banner = 0

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.wrap = false
vim.opt.smartindent = true 

vim.opt.inccommand = "split" 

vim.opt.splitright = true
vim.opt.splitbelow = true 

vim.opt.ignorecase = true
vim.opt.smartcase = true 
vim.opt.laststatus = 3 

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.isfname:append("@-@")

vim.opt.cursorline = true

vim.opt.signcolumn = "yes"
vim.opt.list = true -- show invisible characters
vim.opt.listchars = { space = "·", trail = "·", tab = "→ ", eol = "↲", nbsp = "␣" }

vim.o.cmdheight = 0

vim.opt.mouse = "a"

vim.opt.spell = true
vim.opt.spelllang = "en_us"
vim.opt.termguicolors = true

vim.schedule(function()
    vim.opt.clipboard:append("unnamedplus")
end)

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})
