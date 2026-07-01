-- copy current file relative path from file's directory
return function()
    local full_path = vim.fn.expand "%:p"
    local current_dir = vim.fn.getcwd()
    local relative_path = vim.fn.fnamemodify(full_path, ":." .. current_dir)

    vim.fn.setreg("+", relative_path)

    print("copied to clipboard: " .. relative_path)
end
