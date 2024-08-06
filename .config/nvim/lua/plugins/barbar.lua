return {
    {
        "romgrk/barbar.nvim",
        version = "^1.0.0",
        dependencies = {
            "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
            "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
        },
        config = function()
            vim.g.barbar_auto_setup = false

            require("barbar").setup {}
        end,
    },
}
