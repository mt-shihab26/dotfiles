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

function M.format_on_save()
    if vim.g.disable_autoformat then
        vim.g.disable_autoformat = false
        print "format on save enabled"
    else
        vim.g.disable_autoformat = true
        print "format on save disabled"
    end
end

function M.format_disable()
    vim.g.disable_autoformat = true
    print "format on save disabled"
end

-- disable format on save only for :wa itself, so writing all buffers doesn't
-- reformat everything at once, without permanently turning off format on save
function M.write_all_no_format()
    vim.g.disable_autoformat = true
    vim.cmd.wa()
    vim.g.disable_autoformat = false
end

return M
