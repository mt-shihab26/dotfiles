return {
    {
        "kdheepak/lazygit.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
        },
        cmd = {
            "LazyGit",
        },
        keys = {
            { "<leader>z", "<cmd>LazyGit<cr>", desc = "open lazygit", remap = true },
        },
    },
    {
        "tpope/vim-fugitive",
    },
}
