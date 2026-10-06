vim.pack.add {
    {
        src = "https://github.com/neovim/nvim-lspconfig",
        version = vim.version.range "2",
    },
    {
        src = "https://github.com/antosha417/nvim-lsp-file-operations",
        version = vim.version.range "1",
    },
    {
        src = "https://github.com/j-hui/fidget.nvim",
        version = vim.version.range "2",
    },
}

local fidget = require "fidget"
local lsp_file_operations = require "lsp-file-operations"
local cmp_nvim_lsp = require "cmp_nvim_lsp"
local lsp = require "lib.lsp"

fidget.setup { notification = { window = { winblend = 0 } } }

lsp_file_operations.setup {}

local capabilities = vim.tbl_deep_extend(
    "force",
    vim.lsp.protocol.make_client_capabilities(),
    cmp_nvim_lsp.default_capabilities(),
    lsp_file_operations.default_capabilities()
)

-- every client start (including vim.lsp.enable) goes through vim.lsp.start
local lsp_start = vim.lsp.start
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.start = function(config, opts)
    local bufnr = vim._resolve_bufnr(opts and opts.bufnr)
    if lsp.is_stopped(bufnr) then
        return nil
    end
    return lsp_start(config, opts)
end

local servers = require "lists.servers"

for _, server_name in ipairs(servers) do
    local server_settings = {}
    local ok, settings = pcall(require, "lsp." .. server_name)
    if ok then
        server_settings = settings
    end

    local config = vim.tbl_deep_extend("force", { capabilities = capabilities }, server_settings)

    vim.lsp.config(server_name, config)
    vim.lsp.enable(server_name)
end

local function on_attach(args)
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

    map("n", "gK", buf.signature_help, opts "signature help (lspconfig)")
    map("n", "<leader>a", buf.code_action, opts "code actions (lspconfig)")
    map("n", "<leader>r", buf.rename, opts "rename symbol (lspconfig)")

    map("n", "[d", function() diagnostic.jump { count = -1, float = true } end, opts "go to prev diagnostic (lspconfig)")
    map("n", "]d", function() diagnostic.jump { count = 1, float = true } end, opts "go to next diagnostic (lspconfig)")

    map("n", "<leader>xs", lsp.start, opts "start lsp server (lspconfig)")
    map("n", "<leader>xS", lsp.stop, opts "stop lsp server (lspconfig)")
    map("n", "<leader>xr", lsp.restart, opts "restart lsp server (lspconfig)")
end

vim.api.nvim_create_autocmd("LspAttach", { callback = on_attach })
