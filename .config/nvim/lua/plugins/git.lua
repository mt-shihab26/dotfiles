return {
    {
        "lewis6991/gitsigns.nvim",
        lazy = false,
        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
                untracked = { text = "┆" },
            },
            signs_staged = {
                add = { text = "│" },
                change = { text = "≈" },
                delete = { text = "▁" },
                topdelete = { text = "▔" },
                changedelete = { text = "≋" },
                untracked = { text = "║" },
            },
            current_line_blame = false,
            current_line_blame_opts = {
                virt_text = true,
                delay = 500,
            },
        },
    },
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
    {
        "sindrets/diffview.nvim",
        keys = {
            { "<leader>d", "<cmd>DiffviewOpen<cr>", desc = "open diff view", remap = true },
        },
    },
}
