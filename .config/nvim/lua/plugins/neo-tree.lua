return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    keys = {
        { "<leader>e", "<cmd>Neotree action=focus<cr>", desc = "focus file tree (neo-tree)", remap = true },
        { "<leader>p", "<cmd>Neotree action=close<cr>", desc = "close file tree (neo-tree)", remap = true },
    },
    opts = {
        filesystem = {
            use_libuv_file_watcher = true,
            hijack_netrw_behavior = "open_current",
            filtered_items = {
                visible = false,
                hide_dotfiles = false,
                hide_gitignored = false,
                hide_hidden = false,
            },
            follow_current_file = {
                enabled = true,
                leave_dirs_open = true,
            },
        },
    },
}
