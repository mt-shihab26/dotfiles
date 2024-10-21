-- File browser tree

return {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
        filesystem = {
            filtered_items = {
                hide_dotfiles = false,
                hide_gitignored = false,
            },
        },
    },
    keys = {
        { "<leader>e", "<cmd>Neotree action=focus<cr>", desc = "focus file tree", remap = true },
        { "<leader>p", "<cmd>Neotree action=close<cr>", desc = "close file tree", remap = true },
        { "<C-n>", "<cmd>Neotree toggle<cr>", desc = "toggle file tree", remap = true },
    },
}
