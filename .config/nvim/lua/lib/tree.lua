local M = {}

function M.focus()
    vim.cmd "Neotree action=focus"
end

function M.close()
    vim.cmd "Neotree action=close"
end

return M
