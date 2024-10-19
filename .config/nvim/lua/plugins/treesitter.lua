-- Treesitter

return {
    "nvim-treesitter/nvim-treesitter",
    opts = {
        auto_install = true,
        ensure_installed = {
            "php_only",
            "twig",
            "markdown",
            "markdown_inline",
            "templ",
        },
    },
}
