return {
    -- Lua
    lua_ls = require "settings.lua_ls",

    -- JavaScript
    html = {},
    cssls = {},
    tailwindcss = require "settings.tailwindcss",
    vtsls = require "settings.vtsls",
    denols = require "settings.denols",
    astro = {},
    volar = require "settings.volar",

    -- Python
    pyright = require "settings.pyright",

    -- PHP
    intelephense = {},

    -- Elixir
    elixirls = {},

    -- Go
    gopls = require "settings.gopls",
    templ = {},

    -- Rust
    rust_analyzer = {},

    -- Zig
    zls = {},

    -- C/C++
    clangd = {},
}
