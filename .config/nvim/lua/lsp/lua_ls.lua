return {
    -- only start in projects that have a stylua config somewhere above the file; the root is that config's dir
    root_dir = function(bufnr, on_dir)
        local root = vim.fs.root(bufnr, { ".stylua.toml", "stylua.toml" })
        if root then
            on_dir(root)
        end
    end,
}
