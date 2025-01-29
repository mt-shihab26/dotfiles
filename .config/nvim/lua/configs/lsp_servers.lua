return {
    -- TypeScript
    html = {},
    cssls = {},
    tailwindcss = require "settings.tailwindcss",
    vtsls = require "settings.vtsls",
    denols = require "settings.denols",
    astro = {},
    volar = require "settings.volar",

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
