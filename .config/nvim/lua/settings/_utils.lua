local M = {}

function M.root_dir(markers)
    return function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local root = vim.fs.root(fname, markers)
        if root then
            on_dir(root)
        end
    end
end

return M
