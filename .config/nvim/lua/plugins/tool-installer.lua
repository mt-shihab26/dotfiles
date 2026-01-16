return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        require("mason").setup {}
        require("mason-lspconfig").setup { automatic_enable = false }
        require("mason-tool-installer").setup {
            ensure_installed = require "lists.binaries",
            auto_update = false,
            run_on_start = true,
            integrations = { ["mason-lspconfig"] = true },
        }
    end,
}
