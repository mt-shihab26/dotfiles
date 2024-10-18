return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
        indent = {
            char = "│",
            tab_char = "│",
        },
        scope = {
            show_start = false,
        },
        exclude = {
            filetypes = {
                "dashboard",
                "neo-tree",
            },
        },
    },
}
