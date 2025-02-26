return {
    -- Markup
    html = {}, -- HTML
    marksman = {}, -- Markdown
    htmx = {}, -- HTMX

    -- Styling
    cssls = {}, -- CSS
    css_variables = {},
    tailwindcss = require "settings.tailwindcss",

    -- Data Formats
    jsonls = {}, -- Json
    yamlls = {}, -- YAML

    -- Shell & System
    bashls = {}, -- Bash
    sqls = {}, -- SQL
    dockerls = {},
    docker_compose_language_service = {},

    -- JavaScript
    vtsls = require "settings.vtsls", -- TypeScript
    volar = require "settings.volar", -- Vue
    astro = {}, -- Astro
    angularls = {}, -- Angular
    svelte = {}, -- Svelte
    prismals = {}, -- Prisma

    -- PHP
    intelephense = {}, -- PHP
    stimulus_ls = {}, -- Blade
    twiggy_language_server = {}, -- Twig

    -- Go
    gopls = require "settings.gopls", -- Go
    templ = {}, -- Go template

    -- Other Languages
    lua_ls = require "settings.lua_ls", -- Lua
    ruby_lsp = {}, -- Ruby
    pyright = require "settings.pyright", -- Python
    elixirls = {}, -- Elixir
    rust_analyzer = {}, -- Rust
    zls = {}, -- Zig
    clangd = {}, -- C/C++
}
