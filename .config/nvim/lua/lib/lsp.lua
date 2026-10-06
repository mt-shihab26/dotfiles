local M = {}

function M.start()
    local bufnr = vim.api.nvim_get_current_buf()
    local ft = vim.bo[bufnr].filetype
    for _, name in ipairs(require "lists.servers") do
        local config = vim.lsp.config[name]
        if config and vim.tbl_contains(config.filetypes or {}, ft) then
            vim.lsp.enable(name)
        end
    end
end

function M.stop()
    local bufnr = vim.api.nvim_get_current_buf()
    for _, client in ipairs(vim.lsp.get_clients { bufnr = bufnr }) do
        vim.lsp.enable(client.name, false)
        client:stop(true)
    end
end

function M.restart()
    local bufnr = vim.api.nvim_get_current_buf()
    for _, client in ipairs(vim.lsp.get_clients { bufnr = bufnr }) do
        local name = client.name
        vim.lsp.enable(name, false)
        client:stop(true)
        vim.defer_fn(function()
            vim.lsp.enable(name)
        end, 500)
    end
end

function M.has_ts7(root)
    local pkg = vim.fs.joinpath(root, "node_modules/typescript/package.json")
    local f = io.open(pkg, "r")
    if not f then return false end
    local content = f:read "*a"
    f:close()
    local major = content:match '"version"%s*:%s*"(%d+)%.'
    return tonumber(major) and tonumber(major) >= 7
end

return M
