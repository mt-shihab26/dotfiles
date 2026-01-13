return {
    enabled = true,
    filetypes = { "eruby", "javascript" },
    root_dir = function(fname)
        return require("lspconfig.util").root_pattern "Gemfile"(fname)
    end,
}
