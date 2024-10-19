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

            -- git
            "git_config",
            "gitcommit",
            "git_rebase",
            "gitignore",
            "gitattributes",

            -- docker
            "dockerfile",

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
            "vue",

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
