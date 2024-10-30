-- file type detection for .env and .env.* files
vim.cmd "augroup dotenv | autocmd! | autocmd BufNewFile,BufRead .env,.env.* setfiletype sh | augroup END"

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup "highlight_yank",
    callback = function()
        vim.highlight.on_yank()
    end,
})
