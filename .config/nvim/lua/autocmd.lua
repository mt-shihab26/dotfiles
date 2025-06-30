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
end)

vim.api.nvim_create_user_command("ToggleWrap", function()
    if vim.wo.wrap then
        vim.wo.wrap = false
        vim.notify("Wrap OFF", vim.log.levels.INFO)
    else
        vim.wo.wrap = true
        vim.notify("Wrap ON", vim.log.levels.INFO)
    end
end)

vim.api.nvim_create_user_command("ToggleCopilot", function()
    -- Check if Copilot is already disabled
    local is_disabled = vim.g.copilot_enabled == false

    if is_disabled then
        -- Enable Copilot
        vim.g.copilot_enabled = true
        vim.cmd "Copilot enable"
        print "copilot enabled"
    else
        -- Disable Copilot
        vim.g.copilot_enabled = false
        vim.cmd "Copilot disable"
        print "copilot disabled"
    end
end)

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
