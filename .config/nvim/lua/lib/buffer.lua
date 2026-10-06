local M = {}

function M.open_last_file()
    local bufname = vim.api.nvim_buf_get_name(0)
    local buftype = vim.bo.buftype
    local modified = vim.bo.modified

    if bufname == "" and buftype == "" and not modified then
        local oldfiles = vim.v.oldfiles
        if #oldfiles > 0 then
            local lastfile = oldfiles[1]
            lastfile = vim.fn.fnameescape(lastfile)
            vim.cmd("edit " .. lastfile)
        else
            vim.notify("No recently opened files found", vim.log.levels.WARN)
        end
    else
        vim.cmd("normal! " .. vim.v.count1 .. "l")
    end
end

function M.close_terminals_or_others()
    local bufs = vim.api.nvim_list_bufs()
    local current = vim.api.nvim_get_current_buf()
    local terminals = {}
    local others = {}

    for _, buf in ipairs(bufs) do
        if vim.api.nvim_buf_is_loaded(buf) and buf ~= current then
            if vim.bo[buf].buftype == "terminal" then
                terminals[#terminals + 1] = buf
            elseif vim.bo[buf].buflisted then
                others[#others + 1] = buf
            end
        end
    end

    local targets = #terminals > 0 and terminals or others
    if #targets == 0 then
        vim.notify("No buffers to close", vim.log.levels.INFO)
        return
    end

    -- force only for terminals; modified buffers go through 'confirm' instead of losing changes
    local bdelete = #terminals > 0 and "bdelete! " or "bdelete "
    for _, buf in ipairs(targets) do
        pcall(vim.cmd, bdelete .. buf)
    end
end

-- true when the comments opening the buffer (after a shebang, if any) include "stop: <feature>",
-- one per line, e.g. "-- stop: lsp" followed by "-- stop: format"
function M.is_stopped(bufnr, feature)
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 10, false)
    local first = (lines[1] or ""):match "^#!" and 2 or 1
    for i = first, #lines do
        local name = lines[i]:match "^%s*%p+%s*stop:%s*(%w+)%s*%p*%s*$"
        if not name then
            return false
        end
        if name == feature then
            return true
        end
    end
    return false
end

return M
