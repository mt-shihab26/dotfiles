return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    keys = {
        { "<leader>e", "<cmd>Neotree action=focus<cr>", desc = "Focus File Tree", remap = true },
        { "<leader>p", "<cmd>Neotree action=close<cr>", desc = "Close File Tree", remap = true },
        { "<C-n>", "<cmd>Neotree toggle<cr>", desc = "Toggle File Tree", remap = true },
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
