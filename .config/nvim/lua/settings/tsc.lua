local lsp_utils = require "utils.lsp"

return {
    enabled = true,
    root_dir = function(bufnr, on_dir)
        local root = vim.fs.root(bufnr, { "package.json", "tsconfig.json", "jsconfig.json", ".git" }) or vim.fn.getcwd()
        if lsp_utils.has_ts7(root) then
            on_dir(root)
        end
    end,
    cmd = function(dispatchers)
        return vim.lsp.rpc.start({ "tsc", "--lsp", "--stdio" }, dispatchers)
    end,
}
