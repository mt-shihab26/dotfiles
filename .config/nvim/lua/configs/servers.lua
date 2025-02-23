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

    -- Python
    pyright = require "settings.pyright",

    -- Zig
    zls = {},

    -- Others
    lua_ls = require "settings.lua_ls",
    elixirls = {},
    gopls = require "settings.gopls",
    templ = {},
    rust_analyzer = {},
    clangd = {},
}
