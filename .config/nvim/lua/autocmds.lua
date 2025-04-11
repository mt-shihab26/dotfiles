-- disable copilot
-- vim.cmd "Copilot disable"

-- file type detection for .env and .env.* files
vim.cmd [[
  augroup dotenv
    autocmd!
    autocmd BufNewFile,BufRead .env,.env.* setfiletype sh
  augroup END
]]

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})
