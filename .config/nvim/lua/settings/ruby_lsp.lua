return {
    enabled = true,
    cmd = { "ruby-lsp" },
    root_markers = { "Gemfile" },
    init_options = {
        formatter = "none",
        enabledFeatures = {
            diagnostics = false,
            codeActions = false,
            formatting = false,
        },
    },
}
