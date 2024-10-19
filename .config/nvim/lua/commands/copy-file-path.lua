-- copy file path
vim.api.nvim_create_user_command("CopyFilePath", function()
    local path = vim.fn.expand "%:p"
    vim.fn.setreg("+", path)
    print("copied: " .. path)
end, {})
