local M = {}

function M.wrap()
    vim.wo.wrap = not vim.wo.wrap
    vim.notify("Wrap " .. (vim.wo.wrap and "ON" or "OFF"), vim.log.levels.INFO)
end

-- only for the current buffer, other buffers keep their own setting
function M.indent_char()
    vim.bo.expandtab = not vim.bo.expandtab

    if vim.bo.expandtab then
        print "using spaces for indentation"
    else
        print "using tabs for indentation"
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

-- disable format on save only for :wa itself, so writing all buffers doesn't
-- reformat everything at once, without permanently turning off format on save
function M.write_all_no_format()
    local previous = vim.g.disable_autoformat
    vim.g.disable_autoformat = true
    local ok, err = pcall(vim.cmd.wa)
    vim.g.disable_autoformat = previous
    if not ok then
        error(err, 0)
    end
end

function M.completion()
    vim.g.cmp_enabled = not vim.g.cmp_enabled
    if not vim.g.cmp_enabled then
        require("cmp").close()
    end
    vim.notify("Completion " .. (vim.g.cmp_enabled and "ON" or "OFF"), vim.log.levels.INFO)
end

-- lsp semantic tokens (priority 125) override treesitter highlights; toggle to compare
function M.semantic_tokens()
    local enable = not vim.lsp.semantic_tokens.is_enabled()
    vim.lsp.semantic_tokens.enable(enable)
    vim.notify("Semantic tokens " .. (enable and "ON" or "OFF"), vim.log.levels.INFO)
end

-- switch between the rendered view (render-markdown) and the raw markdown
function M.markdown_render()
    require("render-markdown").toggle()
end

return M
