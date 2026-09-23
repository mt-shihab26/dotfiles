-- sextant is built and symlinked to ~/.local/bin by .setup/sextant.sh (not Mason).
-- Rebuild/update with: .setup/sextant.sh
-- Debug logging: SEXTANT_LOG=1 nvim
return {
    enabled = true,
    cmd = { "sextant" },
    filetypes = { "lisp" },
    root_dir = function(bufnr, on_dir)
        local root = vim.fs.root(bufnr, function(name)
            return name:match "%.asd$" ~= nil
        end) or vim.fs.root(bufnr, { ".git" }) or vim.fn.getcwd()
        on_dir(root)
    end,
}
