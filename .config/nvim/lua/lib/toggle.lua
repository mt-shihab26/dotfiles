local M = {}

function M.indent_char()
    local current_expand = vim.o.expandtab
    vim.opt.expandtab = not current_expand

    if vim.o.expandtab then
        print "using spaces for indentation"
    else
        print "using tabs for indentation"
    end
end

function M.wrap()
    if vim.wo.wrap then
        vim.wo.wrap = false
        vim.notify("Wrap OFF", vim.log.levels.INFO)
    else
        vim.wo.wrap = true
        vim.notify("Wrap ON", vim.log.levels.INFO)
    end
end

return M
