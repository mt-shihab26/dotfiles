local ensure_installed = {
    -- Markup
    "html",
    "marksman",
    "jsonls",
    "yamlls",
    "cssls",
    "css_variables",
    "tailwindcss",
    -- Shell
    "bashls",
    -- Lua
    "lua_ls",
    -- JavaScript
    "vtsls",
    "astro",
    "vue-language-server",
    -- PHP
    "intelephense",
    -- Python
    "pyright",
    -- Go
    "gopls",
    "templ",
    -- C/C++
}

return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        require("mason").setup {}
        require("mason-lspconfig").setup {
            automatic_enable = false,
        }
        require("mason-tool-installer").setup {
            ensure_installed = ensure_installed,
            auto_update = false,
            run_on_start = true,
            integrations = {
                ["mason-lspconfig"] = true,
            },
        }
    end,
}
