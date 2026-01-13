return {
    enabled = true,
    filetypes = { "ruby", "eruby" },
    root_markers = { "Gemfile" },
    root_dir = require("_utils").root_dir { "Gemfile" },
}
