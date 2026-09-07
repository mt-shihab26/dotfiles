return {
    -- Markup
    html = { "prettier" },
    markdown = { "prettier" },
    mdx = { "prettier" },
    svg = { "prettier" },
    json = { "prettier" },
    yaml = { "prettier" },
    toml = { "prettier" },
    css = { "prettier" },
    sh = { "shfmt" },
    bash = { "shfmt" },
    zsh = { "shfmt" },
    fish = { "shfmt" },
    lua = { "stylua" },
    -- C/C++
    c = { "clang-format" },
    cpp = { "clang-format" },
    -- Python
    python = { "ruff_format" },
    -- Java
    java = { "google-java-format" },
    -- JavaScript
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    vue = { "prettier" },
    astro = { "prettier" },
    -- PHP
    php = { "pint" },
    blade = { "prettier" },
    -- Go
    go = { "goimports", "gofmt" },
    templ = { "templ" },
    -- Rust
    rust = { "rustfmt" }
}
