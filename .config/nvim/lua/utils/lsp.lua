local M = {}

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
