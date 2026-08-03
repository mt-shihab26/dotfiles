local lsp_utils = require "utils.lsp"

return {
    filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
    },
    root_dir = function(bufnr, on_dir)
        local root = vim.fs.root(bufnr, { "package.json", "tsconfig.json", "jsconfig.json", ".git" }) or vim.fn.getcwd()
        if lsp_utils.has_ts7(root) then
            on_dir(root)
        end
    end,
    cmd = function(dispatchers, config)
        local tsc = vim.fs.joinpath((config or {}).root_dir or "", "node_modules/typescript/bin/tsc")
        return vim.lsp.rpc.start({ tsc, "--lsp", "--stdio" }, dispatchers)
    end,
}
