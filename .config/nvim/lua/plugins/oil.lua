return {
    "stevearc/oil.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
        default_file_explorer = true,
        view_options = {
            show_hidden = true,
        },
        -- Enable git status in the UI
        columns = {
            "icon",
            "permissions",
            "size",
            "mtime",
            -- Add git status column
            "git_status",
        },
        -- Configure git integration for highlighting
        win_options = {
            signcolumn = "yes", -- Show signcolumn for git status
        },
    },
    keys = {
        { "-", "<CMD>Oil<CR>", desc = "open directories as buffer (oil)" },
    },
}
