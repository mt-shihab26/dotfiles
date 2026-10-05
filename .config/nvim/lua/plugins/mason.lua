vim.pack.add {
    {
        src = "https://github.com/williamboman/mason.nvim",
        version = vim.version.range "2",
    },
    {
        src = "https://github.com/williamboman/mason-lspconfig.nvim",
        version = vim.version.range "2",
    },
    {
        src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
        version = "main",
    },
}

local mason = require "mason"
local mason_lspconfig = require "mason-lspconfig"
local mason_tool_installer = require "mason-tool-installer"
local binaries = require "lists.binaries"

mason.setup {}
mason_lspconfig.setup { automatic_enable = false }
mason_tool_installer.setup {
    ensure_installed = binaries,
    auto_update = false,
    run_on_start = true,
    integrations = { ["mason-lspconfig"] = true },
}
