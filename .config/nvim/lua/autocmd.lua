-- LSP sends malformed colors (float > 1.0 → >255 → 7-digit hex), disable until upstream fix.
vim.lsp.document_color.enable(false)

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
