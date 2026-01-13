return {
    enabled = true,
    filetypes = { "ruby", "eruby" },
    root_dir = function(fname)
        return require("lspconfig.util").root_pattern "Gemfile"(fname)
    end,
}
