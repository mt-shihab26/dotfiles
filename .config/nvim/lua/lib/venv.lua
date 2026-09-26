local M = {}

-- Finds the nearest .venv directory walking up from `path`.
function M.find(path)
    local venv = vim.fs.find(".venv", { path = path, upward = true, type = "directory" })[1]
    if venv and vim.uv.fs_stat(vim.fs.joinpath(venv, "bin/python")) then
        return venv
    end
end

return M
