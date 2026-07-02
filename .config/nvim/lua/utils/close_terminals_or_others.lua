return function()
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

    for _, buf in ipairs(targets) do
        vim.cmd("bdelete! " .. buf)
    end
end
