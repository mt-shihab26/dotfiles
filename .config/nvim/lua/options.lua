-- line numbering
vim.opt.number = true 
vim.opt.relativenumber = true

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

