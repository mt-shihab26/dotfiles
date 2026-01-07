return {
    enabled = true,
    cmd = { "ruby-lsp" },
    init_options = {
        enabledFeatures = {
            diagnostics = false,
            codeActions = false,
            formatting = false,
        },
        formatter = "none",
    },
}
