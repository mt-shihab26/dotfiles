return {
    -- Conf
    json = { "vp", "prettier", stop_after_first = true },
    yaml = { "vp", "prettier", stop_after_first = true },
    toml = { "vp", "prettier", stop_after_first = true },
    -- HTML
    html = { "vp", "prettier", stop_after_first = true },
    markdown = { "vp", "prettier", stop_after_first = true },
    mdx = { "vp", "prettier", stop_after_first = true },
    svg = { "prettier" },
    -- CSS
    css = { "vp", "prettier", stop_after_first = true },
    -- Bash
    sh = { "shfmt" },
    bash = { "shfmt" },
    zsh = { "shfmt" },
    fish = { "fish_indent" },
    -- Lua
    lua = { "stylua" },
    -- C/C++
    c = { "clang-format" },
    cpp = { "clang-format" },
    -- Python
    python = { "ruff_format" },
    -- Java
    java = { "google-java-format" },
    -- JavaScript
    javascript = { "vp", "prettier", stop_after_first = true },
    javascriptreact = { "vp", "prettier", stop_after_first = true },
    typescript = { "vp", "prettier", stop_after_first = true },
    typescriptreact = { "vp", "prettier", stop_after_first = true },
    vue = { "vp", "prettier", stop_after_first = true },
    astro = { "prettier" },
    -- PHP
    php = { "pint" },
    blade = { "prettier" },
    -- Go
    go = { "goimports", "gofmt" },
    templ = { "templ" },
    -- Rust
    rust = { "rustfmt" },
    -- Ruby
    ruby = { "rubocop" }, -- gem install rubocop rubocop-rails
    eruby = { "erb_format" },
    -- Lisp
    -- no formatter listed, formatted by the sextant LSP (conform lsp_format = "fallback")
}
