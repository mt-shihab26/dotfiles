-- render-markdown is disabled, uncomment to turn it back on
-- vim.pack.add {
--     {
--         src = "https://github.com/MeanderingProgrammer/render-markdown.nvim",
--         version = vim.version.range "8",
--     },
-- }
--
-- local render_markdown = require "render-markdown"
--
-- -- render headings, code blocks, tables, checkboxes and callouts in the buffer;
-- -- the line under the cursor and insert mode show the raw markdown
-- render_markdown.setup {
--     file_types = { "markdown", "mdx" },
--     completions = { lsp = { enabled = true } }, -- checkbox and callout completions through cmp's lsp source
-- }

-- prose reads better soft-wrapped at word boundaries, keeping the indent of list items
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "mdx" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.breakindent = true
    end,
})
