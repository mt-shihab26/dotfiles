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
    -- Ruby
    -- "ruby_lsp",
    -- Python
    "pyright",
    -- Go
    "gopls",
    "templ",
    -- C/C++
    -- clangd = {},
}

return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
        require("mason").setup {}
        require("mason-tool-installer").setup {
            ensure_installed = ensure_installed,
            auto_update = false,
            run_on_start = true,
        }
    end,
}
