return {
    enabled = true,
    cmd = { "ruby-lsp" },
    root_dir = { "Gemfile" },
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
