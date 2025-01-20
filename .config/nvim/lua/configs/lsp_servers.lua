return {
    -- HTML
    html = {},

    -- CSS
    cssls = {},
    tailwindcss = require "settings.tailwindcss",

    -- Lua
    lua_ls = require "settings.lua_ls",

    -- Python
    pyright = require "settings.pyright",

    -- Javascript
    vtsls = require "settings.vtsls",
    astro = {},
    volar = require "settings.volar",
    denols = require "settings.denols",

    -- PHP
    intelephense = {},

    -- ruby
    ruby_lsp = {},

    -- Elixir
    elixirls = {},

    -- Go
    gopls = require "settings.gopls",
    templ = {},

    -- RUST
    rust_analyzer = {},

    -- zig
    zls = {},

    -- C/C++
    clangd = {},
}
