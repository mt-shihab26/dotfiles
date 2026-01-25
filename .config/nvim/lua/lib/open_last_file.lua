return function()
    local bufname = vim.api.nvim_buf_get_name(0)
    local buftype = vim.api.nvim_buf_get_option(0, "buftype")
    local modified = vim.api.nvim_buf_get_option(0, "modified")

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
        vim.cmd "normal! l"
    end
end
