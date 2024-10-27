return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    cmd = "Neotree",
    keys = {
        { "<leader>e", "<cmd>Neotree action=focus<cr>", desc = "focus file tree", remap = true },
        { "<leader>p", "<cmd>Neotree action=close<cr>", desc = "close file tree", remap = true },
        { "<C-n>", "<cmd>Neotree toggle<cr>", desc = "toggle file tree", remap = true },
    },
    opts = {
        filesystem = {
            filtered_items = {
                hide_dotfiles = false,
                hide_gitignored = false,
            },
        },
    },
}
