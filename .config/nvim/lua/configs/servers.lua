return {
    html = {}, -- HTML
    -- htmx = {}, -- HTMX
    -- marksman = {}, -- Markdown

    cssls = {}, -- CSS
    css_variables = {}, -- CSS
    tailwindcss = require "settings.tailwindcss", -- TailwindCSS

    -- jsonls = {}, -- Json
    -- yamlls = {}, -- YAML

    -- bashls = {}, -- Bash

    -- sqls = {}, -- SQL

    -- dockerls = {}, -- Docker
    -- docker_compose_language_service = {}, -- Docker

    vtsls = require "settings.vtsls", -- TypeScript
    -- volar = require "settings.volar", -- Vue
    astro = {}, -- Astro
    -- angularls = {}, -- Angular
    -- svelte = {}, -- Svelte
    -- prismals = {}, -- Prisma

    intelephense = {}, -- PHP
    -- stimulus_ls = {}, -- Blade
    -- twiggy_language_server = {}, -- Twig

    -- gopls = require "settings.gopls", -- Go
    -- templ = {}, -- Go

    lua_ls = require "settings.lua_ls", -- Lua

    -- ruby_lsp = {}, -- Ruby

    -- pyright = require "settings.pyright", -- Python

    -- elixirls = {}, -- Elixir

    -- rust_analyzer = {}, -- Rust

    zls = {}, -- Zig

    -- clangd = {}, -- C/C++
}
