local M = {}

function M.has_ts7(root)
    local pkg = vim.fs.joinpath(root, "node_modules/typescript/package.json")
    local f = io.open(pkg, "r")
    if not f then return false end
    local content = f:read "*a"
    f:close()
    local major = content:match '"version"%s*:%s*"(%d+)%.'
    return tonumber(major) and tonumber(major) >= 7
end

function M.on_attach(args)
    local opts = function(desc)
        return { buffer = args.buf, noremap = true, silent = true, desc = desc }
    end

    local map = vim.keymap.set
    local buf = vim.lsp.buf
    local diagnostic = vim.diagnostic

    map("n", "gd", buf.definition, opts "go to definition (lspconfig)")
    map("n", "gD", buf.declaration, opts "go to declaration (lspconfig)")
    map("n", "gi", buf.implementation, opts "go to implementation (lspconfig)")
    map("n", "gr", buf.references, opts "go to references (lspconfig)")

    map("n", "K", buf.hover, opts "show hover documentation (lspconfig)")
    map("n", "<leader>d", diagnostic.open_float, opts "show hover diagnostics (lspconfig)")

    map("n", "<leader>h", buf.signature_help, opts "signature help (lspconfig)")
    map("n", "<leader>a", buf.code_action, opts "code actions (lspconfig)")
    map("n", "<leader>r", buf.rename, opts "rename symbol (lspconfig)")

    map("n", "[d", diagnostic.goto_prev, opts "go to prev diagnostic (lspconfig)")
    map("n", "]d", diagnostic.goto_next, opts "go to next diagnostic (lspconfig)")

    map("n", "<leader>ls", function()
        vim.cmd "LspStart"
    end, opts "start LSP server")
    map("n", "<leader>lS", function()
        vim.cmd "LspStop"
    end, opts "stop LSP server")
    map("n", "<leader>lr", function()
        vim.cmd "LspRestart"
    end, opts "restart LSP server")
end

return M
