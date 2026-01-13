return {
    enabled = true,
    cmd = { "ruby-lsp" },
    filetypes = { "ruby", "eruby" },
    root_dir = function(fname)
        return require("lspconfig.util").root_pattern "Gemfile"(fname)
    end,
    init_options = {
        formatter = "none",
        enabledFeatures = {
            diagnostics = false,
            codeActions = false,
            formatting = false,
        },
    },
}
