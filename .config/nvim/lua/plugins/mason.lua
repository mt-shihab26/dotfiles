vim.pack.add {
    "https://github.com/williamboman/mason.nvim",
    "https://github.com/williamboman/mason-lspconfig.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
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
