return {
    {
        "lewis6991/gitsigns.nvim",
        lazy = false,
        keys = {
            { "]h", ":silent Gitsigns next_hunk<CR>", { desc = "navigate to the next git hunk (gitsigns)" } },
            { "[h", ":silent Gitsigns prev_hunk<CR>", { desc = "navigate to the previous git hunk (gitsigns)" } },
        },
        opts = {
            preview_config = {
                border = { "", "", "", " " },
            },
            current_line_blame = true,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
                ignore_whitespace = false,
            },
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "┄" },
                untracked = { text = "┆" },
            },
            signs_staged = {
                add = { text = "│" },
                change = { text = "≈" },
                delete = { text = "▁" },
                topdelete = { text = "▔" },
                changedelete = { text = "┈" },
                untracked = { text = "║" },
            },
        },
    },
    {
        "sindrets/diffview.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
        keys = {
            { "<leader>do", "<cmd>DiffviewOpen<cr>", desc = "open git diff view (diffview)" },
            { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "close git diff view (diffview)" },
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
    },
}
