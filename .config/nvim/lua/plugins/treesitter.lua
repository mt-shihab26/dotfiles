-- Treesitter

return {
    "nvim-treesitter/nvim-treesitter",
    opts = {
        auto_install = true,
        ensure_installed = {
            "bash",
            "c",
            "diff",
            "lua",
            "luadoc",
            "luap",
            "printf",
            "python",
            "query",
            "regex",
            "toml",
            "vim",
            "vimdoc",
            "xml",
            "yaml",
            "markdown",
            "markdown_inline",

            -- css
            "html",
            "css",

            -- javascript
            "javascript",
            "jsdoc",
            "json",
            "jsonc",
            "typescript",
            "tsx",
            "astro",

            -- php
            "php",
            "php_only",
            "twig",

            -- go
            "go",
            "gomod",
            "gowork",
            "gosum",
            "templ",
        },
    },
}
