return {
    enabled = true,
    filetypes = { "eruby", "javascript" },
    root_markers = { "Gemfile" },
    root_dir = require("_utils").root_dir { "Gemfile" },
}
