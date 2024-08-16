require "config.treesitter"

return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            auto_install = true,
            ensure_installed = {
                "php",
                "php_only",
                "twig",
                "vue",
                "astro",
            },
        },
    },
}
