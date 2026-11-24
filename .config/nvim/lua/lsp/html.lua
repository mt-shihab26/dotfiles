return {
    -- lspconfig only lists html; the server reads .ejs fine as long as it's told the document is html
    filetypes = { "html", "ejs" },
    get_language_id = function(_, ft)
        return ft == "ejs" and "html" or ft
    end,
}
