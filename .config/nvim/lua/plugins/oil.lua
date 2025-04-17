return {
    "stevearc/oil.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "refractalize/oil-git-status.nvim",
    },
    config = function()
        require("oil").setup {
            default_file_explorer = true,
            view_options = {
                show_hidden = true,
            },
            columns = {
                "icon",
                "permissions",
                "size",
                "mtime",
            },
            win_options = {
                signcolumn = "yes:2",
            },
        }

        require("oil-git-status").setup {
            --
        }
    end,
    keys = {
        { "-", "<CMD>Oil<CR>", desc = "open directories as buffer (oil)" },
    },
}
