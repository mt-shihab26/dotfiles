return {
    enabled = true,
    filetypes = { "eruby", "javascript" },
    root_markers = { "Gemfile" },
    root_dir = require("lspconfig.util").root_pattern "Gemfile",
}
