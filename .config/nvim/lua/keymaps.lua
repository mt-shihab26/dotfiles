vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<cr>", { desc = "clear search highlighting" })

-- disable macro recording
vim.keymap.set("n", "q", "<nop>", { desc = "disabled macro recording", noremap = true })

vim.keymap.set("x", "p", '"_dP', { desc = "paste without yanking selected text", noremap = true })

vim.keymap.set("n", "l", function()
    local bufname = vim.api.nvim_buf_get_name(0)
    local buftype = vim.api.nvim_buf_get_option(0, "buftype")
    local modified = vim.api.nvim_buf_get_option(0, "modified")

    if bufname == "" and buftype == "" and not modified then
        local oldfiles = vim.v.oldfiles
        if #oldfiles > 0 then
            local lastfile = oldfiles[1]
            lastfile = vim.fn.fnameescape(lastfile)
            vim.cmd("edit " .. lastfile)
        else
            vim.notify("No recently opened files found", vim.log.levels.WARN)
        end
    else
        vim.cmd "normal! l"
    end
end, { desc = "open last file or move right", noremap = true })

vim.keymap.set("n", "<leader>x", "<cmd>CFExe<cr>", { desc = "execute current file based on language of cp" })

-- moving around nvim windows
vim.keymap.set("n", "<leader>h", "<C-w>h", { desc = "move to left window", noremap = true, silent = true })
vim.keymap.set("n", "<leader>j", "<C-w>j", { desc = "move to below window", noremap = true, silent = true })
vim.keymap.set("n", "<leader>k", "<C-w>k", { desc = "move to above window", noremap = true, silent = true })
vim.keymap.set("n", "<leader>l", "<C-w>l", { desc = "move to right window", noremap = true, silent = true })

-- toggle things
vim.keymap.set("n", "<leader>ti", "<cmd>ToggleIndenChar<cr>", { desc = "toggle tabs/spaces for indentation" })
vim.keymap.set("n", "<leader>tw", "<cmd>ToggleWrap<cr>", { desc = "toggle line wrapping on/off" })
vim.keymap.set("n", "<leader>tc", "<cmd>ToggleCopilot<cr>", { desc = "toggle gitHub copilot on/off" })

-- copy current file relative path from file's directory
vim.api.nvim_create_user_command("CopyFilePath", function()
    local full_path = vim.fn.expand "%:p"
    local current_dir = vim.fn.getcwd()
    local relative_path = vim.fn.fnamemodify(full_path, ":." .. current_dir)
    vim.fn.setreg("+", relative_path)
    print("Copied to clipboard: " .. relative_path)
end, { desc = "Copy current file path relative to cwd" })

vim.keymap.set("n", "<leader>cp", "<cmd>CopyFilePath<cr>", { desc = "copy current file relative path" })

-- copy current file absolute path
vim.api.nvim_create_user_command("CopyFileAbsPath", function()
    local full_path = vim.fn.expand "%:p"
    vim.fn.setreg("+", full_path)
    print("Copied to clipboard: " .. full_path)
end, { desc = "Copy current file absolute path" })

vim.keymap.set("n", "<leader>ca", "<cmd>CopyFileAbsPath<cr>", { desc = "copy current file absolute path" })

-- copy current file name with extension
vim.api.nvim_create_user_command("CopyFileName", function()
    local file_name = vim.fn.expand "%:t"
    vim.fn.setreg("+", file_name)
    print("Copied to clipboard: " .. file_name)
end, { desc = "Copy current file name with extension" })

vim.keymap.set("n", "<leader>cf", "<cmd>CopyFileName<cr>", { desc = "copy current file name with extension" })

-- git wip commit
vim.api.nvim_create_user_command("Wip", function(opts)
    local message
    if opts.args ~= "" then
        message = opts.args
    else
        message = vim.fn.input "commit message (empty for 'wip'): "
        if message == "" then
            message = "wip"
        end
    end
    vim.fn.system(string.format("git add . && git commit -m '%s' && git push origin HEAD", message))
    if vim.v.shell_error == 0 then
        print("\ncommitted and pushed: " .. message)
    else
        print "\nerror running git wip"
    end
end, { nargs = "?", desc = "Quick WIP commit and push" })

vim.keymap.set("n", "<leader>w", "<cmd>Wip<cr>", { desc = "git wip commit and push" })
