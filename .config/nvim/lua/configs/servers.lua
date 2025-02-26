return {
    jsonls = {}, -- Json
    yamlls = {}, -- YAML
    bashls = {}, -- Bash
    sqls = {}, -- SQL
    html = {}, -- HTML
    lua_ls = require "settings.lua_ls", -- Lua
    ruby_lsp = {}, -- Ruby
    pyright = require "settings.pyright", -- Python
    elixirls = {}, -- Elixir
    rust_analyzer = {}, -- Rust
    zls = {}, -- Zig
    clangd = {}, -- C/C++
    marksman = {}, -- Markdown

    -- CSS
    cssls = {},
    css_variables = {},
    tailwindcss = require "settings.tailwindcss",

    -- JavaScript
    htmx = {}, -- HTMX
    vtsls = require "settings.vtsls", -- TypeScript
    volar = require "settings.volar", -- Vue
    astro = {}, -- Astro
    angularls = {}, -- Angular
    prismals = {}, -- Prisma
    svelte = {}, -- Svelte

    -- PHP
    intelephense = {}, -- PHP
    stimulus_ls = {}, -- Blade
    twiggy_language_server = {}, -- Twig

    -- Go
    gopls = require "settings.gopls",
    templ = {},

    -- Docker
    dockerls = {},
    docker_compose_language_service = {},
}
