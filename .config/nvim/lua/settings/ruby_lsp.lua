return {
    enabled = true,
    cmd = { "ruby-lsp" },
    filetypes = { "ruby", "eruby" },
    init_options = {
        formatter = "none",
        enabledFeatures = {
            diagnostics = false,
            codeActions = false,
            formatting = false,
        },
    },
}
