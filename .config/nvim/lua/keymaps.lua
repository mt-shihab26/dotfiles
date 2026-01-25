vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<cr>", { desc = "clear search highlighting", noremap = true })
vim.keymap.set("n", "q", "<nop>", { desc = "disabled macro recording", noremap = true })
vim.keymap.set("x", "p", '"_dP', { desc = "paste without yanking selected text", noremap = true })

vim.keymap.set("n", "<leader>h", "<C-w>h", { desc = "move to left window", noremap = true, silent = true })
vim.keymap.set("n", "<leader>j", "<C-w>j", { desc = "move to below window", noremap = true, silent = true })
vim.keymap.set("n", "<leader>k", "<C-w>k", { desc = "move to above window", noremap = true, silent = true })
vim.keymap.set("n", "<leader>l", "<C-w>l", { desc = "move to right window", noremap = true, silent = true })

vim.keymap.set("n", "l", require "utils.open_last_file", { desc = "open last file or move right", noremap = true })
vim.keymap.set("n", "<leader>ti", require "utils.toggle_indent_char", { desc = "toggle tabs/spaces for indentation" })
vim.keymap.set("n", "<leader>tw", require "utils.toggle_wrap", { desc = "toggle line wrapping on/off" })

vim.keymap.set("n", "<leader>cp", require "utils.copy_file_path", { desc = "copy current file relative path" })
vim.keymap.set("n", "<leader>ca", require "utils.copy_file_abs_path", { desc = "copy current file absolute path" })

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
