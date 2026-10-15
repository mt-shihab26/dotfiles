-- Hide marksman's "Link to non-existent document" warnings.
return {
    handlers = {
        ["textDocument/publishDiagnostics"] = function(err, result, ctx)
            result.diagnostics = vim.tbl_filter(function(d)
                return not d.message:find("Link to non-existent document", 1, true)
            end, result.diagnostics)
            vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx)
        end,
    },
}
