return {
    "kdheepak/lazygit.nvim",
    -- enabled = false,
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim",
    },
    cmd = {
        "LazyGit",
    },
    keys = {
        { "<leader>L", "<cmd>LazyGit<cr>", desc = "open lazygit window (lazygit)", remap = true },
    },
}
