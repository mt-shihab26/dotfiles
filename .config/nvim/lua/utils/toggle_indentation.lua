return function()
    local current_expand = vim.api.nvim_get_option "expandtab"
    vim.opt.expandtab = not current_expand

    if vim.api.nvim_get_option "expandtab" then
        print "using spaces for indentation"
    else
        print "using tabs for indentation"
    end
end
