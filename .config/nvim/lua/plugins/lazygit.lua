return {
    "kdheepak/lazygit.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim",
    },
    cmd = {
        "LazyGit",
    },
    keys = {
        { "<leader>lg", "<cmd>LazyGit<cr>", desc = "open lazygit", remap = true },
    },
}
