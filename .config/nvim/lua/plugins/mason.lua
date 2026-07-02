vim.pack.add({
  "https://github.com/williamboman/mason.nvim",
  "https://github.com/williamboman/mason-lspconfig.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
})

require("mason").setup {}
require("mason-lspconfig").setup { automatic_enable = false }
require("mason-tool-installer").setup {
  ensure_installed = require "lists.binaries",
  auto_update = false,
  run_on_start = true,
  integrations = { ["mason-lspconfig"] = true },
}
