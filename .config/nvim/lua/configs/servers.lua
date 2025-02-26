return {
    -- Json
    jsonls = {},
    -- YAML
    yamlls = {},
    -- Bash
    bashls = {},
    -- SQL
    sqls = {},
    -- HTML
    html = {},
    -- CSS
    cssls = {},
    css_variables = {},
    tailwindcss = require "settings.tailwindcss",
    -- Lua
    lua_ls = require "settings.lua_ls",
    -- Markdown
    marksman = {},
    mdx_analyzer = {},
    -- JavaScript
    vtsls = require "settings.vtsls", -- TypeScript
    htmx = {},
    volar = require "settings.volar", -- Vue
    astro = {}, -- Astro
    angularls = {}, -- Angular
    prismals = {}, -- Prisma
    svelte = {}, -- Svelte
    -- Ruby
    ruby_lsp = {},
    -- Python
    pyright = require "settings.pyright",
    -- PHP
    intelephense = {}, -- PHP
    stimulus_ls = {}, -- Blade
    twiggy_language_server = {}, -- Twig
    -- Elixir
    elixirls = {},
    -- C#
    csharp_ls = {},
    -- Java
    jdtls = {},
    gradle_ls = {},
    kotlin_language_server = {},
    -- Go
    gopls = require "settings.gopls",
    templ = {},
    -- Rust
    rust_analyzer = {},
    -- Zig
    zls = {},
    -- C/C++
    clangd = {},
    -- Docker
    dockerls = {},
    docker_compose_language_service = {},
}
