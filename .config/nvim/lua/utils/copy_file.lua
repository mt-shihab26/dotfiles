local M = {}

function M.path()
    local full_path = vim.fn.expand "%:p"
    local current_dir = vim.fn.getcwd()
    local relative_path = vim.fn.fnamemodify(full_path, ":." .. current_dir)
    vim.fn.setreg("+", relative_path)
    print("copied to clipboard: " .. relative_path)
end

function M.abs_path()
    local full_path = vim.fn.expand "%:p"
    vim.fn.setreg("+", full_path)
    print("copied to clipboard: " .. full_path)
end

function M.name()
    local file_name = vim.fn.expand "%:t"
    vim.fn.setreg("+", file_name)
    print("copied to clipboard: " .. file_name)
end

return M
