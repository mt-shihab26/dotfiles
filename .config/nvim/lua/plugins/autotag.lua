return {
    {
        "windwp/nvim-ts-autotag",
        ft = {
            "html",
            "php",
            "blade",
            "twig",
            "javascriptreact",
            "typescriptreact",
        },
        config = function()
            require("nvim-ts-autotag").setup {}
        end,
    },
}
