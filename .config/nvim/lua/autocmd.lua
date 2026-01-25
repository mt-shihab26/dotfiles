vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Blade files: set filetype to php (for LSP) but use blade treesitter parser (for highlighting)
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.blade.php",
    callback = function()
        vim.bo.filetype = "php"
        vim.treesitter.start(nil, "blade")
    end,
})
