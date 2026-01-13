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
    "shfmt",
    -- Lua
    "lua_ls",
    "stylua",
    -- JavaScript
    "vtsls",
    "astro",
    "vue-language-server",
    "prettier",
    -- PHP
    "intelephense",
    -- Ruby
    -- "ruby_lsp",
    "turbo_ls",
    "stimulus_ls",
    -- Python
    -- "pyright",
    -- "ruff",
    -- C/C++
    -- "clangd"
    -- "clang-format",
    -- Go
    -- "gopls",
    -- "templ",
    -- "goimports",
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
