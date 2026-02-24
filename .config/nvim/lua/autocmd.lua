vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Treat .mdx files as the "mdx" filetype.
vim.filetype.add {
    extension = {
        mdx = "mdx",
    },
}
