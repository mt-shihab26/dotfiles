-- Treesitter

return {
    "nvim-treesitter/nvim-treesitter",
    opts = {
        auto_install = true,
        ensure_installed = {
            "markdown",
            "markdown_inline",
            "templ",

            -- css
            "html",
            "css",

            -- php
            "php",
            "php_only",
            "twig",

            -- go
            "go",
            "gomod",
            "gowork",
            "gosum",
        },
    },
}
