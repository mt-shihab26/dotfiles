return function()
    local closed_terminal = false
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[buf].buftype == "terminal" then
            vim.api.nvim_buf_delete(buf, { force = true })
            closed_terminal = true
        end
    end
    if not closed_terminal then
        vim.cmd "BufferLineCloseOthers"
    end
end
