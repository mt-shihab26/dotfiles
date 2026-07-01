-- copy current file absolute path
return function()
    local full_path = vim.fn.expand "%:p"
    vim.fn.setreg("+", full_path)
    print("Copied to clipboard: " .. full_path)
end
