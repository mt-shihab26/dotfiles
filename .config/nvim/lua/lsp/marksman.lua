-- Hide marksman's link warnings: missing documents, and ambiguous/duplicate names
-- (e.g. vendored LICENSE.md files clashing with a link to LICENSE).
-- lspconfig only lists "markdown.mdx", but .mdx files get the plain "mdx" filetype here.
local hidden = {
    "Link to non-existent document",
    "Ambiguous link to document",
    "Duplicate definition of document",
}

return {
    filetypes = { "markdown", "mdx" },
    handlers = {
        ["textDocument/publishDiagnostics"] = function(err, result, ctx)
            result.diagnostics = vim.tbl_filter(function(d)
                for _, message in ipairs(hidden) do
                    if d.message:find(message, 1, true) then
                        return false
                    end
                end
                return true
            end, result.diagnostics)
            vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx)
        end,
    },
}
