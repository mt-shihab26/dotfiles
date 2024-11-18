return {
    -- Lua
    lua_ls = require "settings.lua_ls",

    -- Python
    pyright = require "settings.pyright",

    -- RUST
    rust_analyzer = {},

    -- C/C++
    -- clangd = {},

    -- Elixir
    elixirls = {},

    -- HTML
    html = {},

    -- CSS
    cssls = {},
    tailwindcss = require "settings.tailwindcss",

    -- Javascript
    vtsls = require "settings.vtsls",
    astro = {},
    volar = require "settings.volar",

    -- PHP
    intelephense = {},

    -- ruby
    ruby_lsp = {},

    -- Go
    gopls = require "settings.gopls",
    templ = {},
}
