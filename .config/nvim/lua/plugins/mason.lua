local lazy = require "lib.lazy"

-- loads right after startup, before plugins/lspconfig.lua starts servers from the Mason bin directory it adds to PATH
lazy.add({
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
}, {
    defer = true,
    commands = {
        "Mason",
        "MasonInstall",
        "MasonLog",
        "MasonUninstall",
        "MasonUninstallAll",
        "MasonUpdate",
        "LspInstall",
        "LspUninstall",
        "MasonToolsClean",
        "MasonToolsInstall",
        "MasonToolsInstallSync",
        "MasonToolsUpdate",
        "MasonToolsUpdateSync",
    },
    setup = function()
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
        -- run_on_start hooks VimEnter from the plugin/ file, which has already fired by the time this deferred
        -- plugin loads, so start the install check here
        mason_tool_installer.run_on_start()
    end,
})
