vim.pack.add {
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/antosha417/nvim-lsp-file-operations" },
    { src = "https://github.com/j-hui/fidget.nvim" },
}

local fidget = require "fidget"
local lsp_file_operations = require "lsp-file-operations"
local cmp_nvim_lsp = require "cmp_nvim_lsp"

fidget.setup { notification = { window = { winblend = 0 } } }

lsp_file_operations.setup {}

local capabilities = vim.tbl_deep_extend(
    "force",
    vim.lsp.protocol.make_client_capabilities(),
    cmp_nvim_lsp.default_capabilities(),
    lsp_file_operations.default_capabilities()
)

vim.lsp.handlers["textDocument/definition"] = function(_, result, _, _)
    if not result or vim.tbl_isempty(result) then
        vim.notify("No definition found", vim.log.levels.WARN)
        return
    end

    if vim.tbl_islist(result) and #result > 0 then
        vim.lsp.util.jump_to_location(result[1], "utf-8")
    else
        vim.lsp.util.jump_to_location(result, "utf-8")
    end
end

local servers = require "lists.servers"

for _, server_name in ipairs(servers) do
    local server_settings = {}
    local ok, settings = pcall(require, "settings." .. server_name)
    if ok then
        server_settings = settings
    end

    local config = vim.tbl_deep_extend("force", { capabilities = capabilities }, server_settings)

    vim.lsp.config(server_name, config)
    vim.lsp.enable(server_name)
end

local lsp = require "lib.lsp"

vim.api.nvim_create_autocmd("LspAttach", { callback = lsp.on_attach })
