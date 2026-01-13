return {
    enabled = true,
    filetypes = { "ruby", "eruby" },
    root_markers = { "Gemfile" },
    root_dir = require("lspconfig.util").root_pattern "Gemfile",
}
