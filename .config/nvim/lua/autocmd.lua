vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_user_command("ToggleIndenChar", function()
    local current_expand = vim.api.nvim_get_option "expandtab"
    vim.opt.expandtab = not current_expand

    if vim.api.nvim_get_option "expandtab" then
        print "using spaces for indentation"
    else
        print "using tabs for indentation"
    end
end, {})

vim.api.nvim_create_user_command("ToggleWrap", function()
    if vim.wo.wrap then
        vim.wo.wrap = false
        vim.notify("Wrap OFF", vim.log.levels.INFO)
    else
        vim.wo.wrap = true
        vim.notify("Wrap ON", vim.log.levels.INFO)
    end
end, {})

-- Blade files: set filetype to php (for LSP) but use blade treesitter parser (for highlighting)
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.blade.php",
    callback = function()
        vim.bo.filetype = "php"
        vim.treesitter.start(nil, "blade")
    end,
})
