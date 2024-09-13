return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        keys = {
            { "<leader>e", "<CMD>Neotree action=focus<CR>", desc = "Focus File Tree", remap = true },
            { "<leader>p", "<CMD>Neotree action=close<CR>", desc = "Close File Tree", remap = true },
            { "<C-n>", "<CMD>Neotree toggle<CR>", desc = "Toggle File Tree", remap = true },
        },
        opts = {
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = false,
                },
            },
        },
    },
}
