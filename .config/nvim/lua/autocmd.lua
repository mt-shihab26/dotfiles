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
end, {})

vim.api.nvim_create_user_command("ToggleWrap", function()
    if vim.wo.wrap then
        vim.wo.wrap = false
        vim.notify("Wrap OFF", vim.log.levels.INFO)
    else
        vim.wo.wrap = true
        vim.notify("Wrap ON", vim.log.levels.INFO)
    end
end, {})

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
end, {})

vim.api.nvim_create_user_command("Exe", function()
    local ft = vim.bo.filetype
    local filename = vim.fn.expand "%"
    local term_cmd = ""

    if ft == "c" then
        term_cmd = "gcc " .. filename .. " -o ~/.tmp/gcc.out && ~/.tmp/gcc.out"
    elseif ft == "cpp" then
        term_cmd = "g++ " .. filename .. " -o ~/.tmp/gpp.out && ~/.tmp/gpp.out"
    elseif ft == "rust" then
        term_cmd = "cargo run"
    elseif ft == "go" then
        term_cmd = "go run " .. filename
    else
        print("Unsupported filetype: " .. ft)
        return
    end

    -- Open terminal in a horizontal split and run the command
    vim.cmd("split | terminal bash -c '" .. term_cmd .. "; exec bash'")

    -- Enter insert mode automatically
    vim.cmd "startinsert"
end, {})

vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    callback = function()
        vim.keymap.set("t", "<leader>q", "<C-\\><C-n>:bd!<CR>", { buffer = true, desc = "close terminal buffer" })
    end,
})
