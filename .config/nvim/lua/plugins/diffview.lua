return {
    "sindrets/diffview.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    cmd = {
        "DiffviewOpen",
        "DiffviewClose",
        "DiffviewToggleFiles",
        "DiffviewFocusFiles",
        "DiffviewFileHistory",
    },
    keys = {
        { "<leader>do", "<cmd>DiffviewOpen<cr>", desc = "open git diff view (diffview)" },
        { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "close git diff view (diffview)" },
        { "<leader>de", "<cmd>DiffviewToggleFiles<cr>", desc = "open the file panel (diffview)" },
        { "<leader>dp", "<cmd>DiffviewToggleFiles<cr>", desc = "close the file panel (diffview)" },
        { "<leader>dh", "<cmd>DiffviewFileHistory<cr>", desc = "open git file history (diffview)" },
        { "<leader>df", "<cmd>DiffviewFileHistory %<cr>", desc = "open current file history (diffview)" },
    },
    opts = {
        diff_binaries = false,
        enhanced_diff_hl = false,
        use_icons = true,
        show_help_hints = true,
        watch_index = true,
        icons = {
            folder_closed = "",
            folder_open = "",
        },
        signs = {
            fold_closed = "",
            fold_open = "",
            done = "✓",
        },
        view = {
            default = {
                layout = "diff2_horizontal",
                disable_diagnostics = false,
                winbar_info = false,
            },
            merge_tool = {
                layout = "diff3_horizontal",
                disable_diagnostics = true,
                winbar_info = true,
            },
            file_history = {
                layout = "diff2_horizontal",
                disable_diagnostics = false,
                winbar_info = false,
            },
        },
        file_panel = {
            listing_style = "tree",
            tree_options = {
                flatten_dirs = true,
                folder_statuses = "only_folded",
            },
            win_config = {
                position = "left",
                width = 35,
                win_opts = {},
            },
        },
        file_history_panel = {
            log_options = {
                git = {
                    single_file = {
                        diff_merges = "combined",
                    },
                    multi_file = {
                        diff_merges = "first-parent",
                    },
                },
            },
            win_config = {
                position = "bottom",
                height = 16,
                win_opts = {},
            },
        },
    },
}
