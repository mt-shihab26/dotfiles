-- line numbering
vim.opt.number = true 
vim.opt.relativenumber = true

-- highlight the current line
vim.opt.cursorline = true 

-- show invisible characters
vim.opt.signcolumn = "yes"
vim.opt.list = true 
vim.opt.listchars = { space = "·", trail = "·", tab = "→ ", eol = "↲", nbsp = "␣" }

-- don't wrap lines
vim.wo.wrap = false 

-- use system clipboard
vim.schedule(function()
    vim.opt.clipboard = "unnamedplus" 
end)

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

