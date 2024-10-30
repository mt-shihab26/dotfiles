return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        "3rd/image.nvim",
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
                visible = false,
                hide_dotfiles = false,
                hide_gitignored = false,
                hide_by_name = {
                    ".DS_Store",
                    ".git",
                },
            },
            follow_current_file = {
                enabled = true,
                leave_dirs_open = true,
            },
            hijack_netrw_behavior = "open_current",
            use_libuv_file_watcher = true,
        },
    },
}
