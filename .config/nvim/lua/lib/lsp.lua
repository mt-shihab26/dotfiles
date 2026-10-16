local M = {}

function M.definition()
    vim.lsp.buf.definition()
end

function M.declaration()
    vim.lsp.buf.declaration()
end

function M.implementation()
    vim.lsp.buf.implementation()
end

function M.references()
    vim.lsp.buf.references()
end

function M.hover()
    vim.lsp.buf.hover()
end

function M.signature_help()
    vim.lsp.buf.signature_help()
end

function M.code_action()
    vim.lsp.buf.code_action()
end

function M.rename()
    vim.lsp.buf.rename()
end

function M.diagnostic_float()
    vim.diagnostic.open_float()
end

-- jump to the previous / next diagnostic and show it in a float
function M.prev_diagnostic()
    vim.diagnostic.jump { count = -1, float = true }
end

function M.next_diagnostic()
    vim.diagnostic.jump { count = 1, float = true }
end

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
