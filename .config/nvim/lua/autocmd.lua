vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_user_command("ToggleIndenChar", function()
    local current_expand = vim.api.nvim_get_option "expandtab"
    vim.opt.expandtab = not current_expand

    if vim.api.nvim_get_option "expandtab" then
        print "using spaces for indentation"
    else
        print "using tabs for indentation"
    end
end, { desc = "toggle tabs/spaces for indentation" })

vim.api.nvim_create_user_command("Exe", function()
    local ft = vim.bo.filetype
    local filename = vim.fn.expand "%"
    local basename = vim.fn.expand "%:r"

    if ft == "c" then
        vim.cmd("!gcc " .. filename .. " -o " .. basename .. " && ./" .. basename)
    elseif ft == "cpp" then
        vim.cmd("!g++ " .. filename .. " -o " .. basename .. " && ./" .. basename)
    elseif ft == "rust" then
        vim.cmd "!cargo run"
    elseif ft == "go" then
        vim.cmd("!go run " .. filename)
    else
        print("Unsupported filetype: " .. ft)
    end
end, {})
