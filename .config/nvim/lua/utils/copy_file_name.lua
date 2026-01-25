return function()
    local file_name = vim.fn.expand "%:t"
    vim.fn.setreg("+", file_name)
    print("Copied to clipboard: " .. file_name)
end
