vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<cr>", { desc = "clear search highlighting" })

vim.keymap.set("x", "p", '"_dP', { desc = "paste without yanking selected text", noremap = true })

-- moving around nvim windows
vim.keymap.set("n", "<leader>h", "<C-w>h", { desc = "move to left window", noremap = true, silent = true })
vim.keymap.set("n", "<leader>j", "<C-w>j", { desc = "move to below window", noremap = true, silent = true })
vim.keymap.set("n", "<leader>k", "<C-w>k", { desc = "move to above window", noremap = true, silent = true })
vim.keymap.set("n", "<leader>l", "<C-w>l", { desc = "move to right window", noremap = true, silent = true })

-- toggle things
vim.keymap.set("n", "<leader>ti", function()
    local current_expand = vim.api.nvim_get_option "expandtab"
    vim.opt.expandtab = not current_expand

    if vim.api.nvim_get_option "expandtab" then
        print "using spaces for indentation"
    else
        print "using tabs for indentation"
    end
end, { desc = "toggle tabs/spaces for indentation" })

vim.keymap.set("n", "<leader>tw", function()
    if vim.wo.wrap then
        vim.wo.wrap = false
        vim.notify("Wrap OFF", vim.log.levels.INFO)
    else
        vim.wo.wrap = true
        vim.notify("Wrap ON", vim.log.levels.INFO)
    end
end, { desc = "toggle line wrapping on/off" })

vim.keymap.set("n", "<leader>tc", function()
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
end, { desc = "toggle gitHub copilot on/off" })
