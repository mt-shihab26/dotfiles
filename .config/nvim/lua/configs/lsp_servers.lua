return {
    -- TypeScript
    html = {},
    cssls = {},
    tailwindcss = require "settings.tailwindcss",
    vtsls = require "settings.vtsls",
    astro = {},
    volar = require "settings.volar",
    denols = require "settings.denols",

    -- PHP
    intelephense = {},

    -- Elixir
    elixirls = {},

    -- Zig
    zls = {},

    -- Others
    lua_ls = require "settings.lua_ls",
    pyright = require "settings.pyright",
    gopls = require "settings.gopls",
    templ = {},
    rust_analyzer = {},
    clangd = {},
}
