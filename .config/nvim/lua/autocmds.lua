-- disable format on save only for :wa itself, so writing all buffers doesn't
-- reformat everything at once, without permanently turning off format on save
vim.api.nvim_create_user_command("Wa", function()
    local prev_disable_autoformat = vim.g.disable_autoformat
    vim.g.disable_autoformat = true
    vim.cmd.wa()
    vim.g.disable_autoformat = prev_disable_autoformat
end, { desc = "write all buffers without formatting" })

vim.cmd [[cnoreabbrev <expr> wa (getcmdtype() == ':' && getcmdline() == 'wa') ? 'Wa' : 'wa']]
