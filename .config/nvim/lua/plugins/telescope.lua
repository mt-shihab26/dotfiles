return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "nvim-telescope/telescope-live-grep-args.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
    },
    keys = {
        {
            "<leader>f",
            function()
                require("telescope.builtin").find_files {
                    prompt_title = "Find Files",
                }
            end,
            desc = "Find files (respect gitignored)",
        },
        {
            "<leader>F",
            function()
                require("telescope.builtin").find_files {
                    prompt_title = "Find All Files",
                    no_ignore = true,
                }
            end,
            desc = "Find all files (include gitignored)",
        },
        {
            "<leader>g",
            function()
                require("telescope").extensions.live_grep_args.live_grep_args {
                    prompt_title = "Grep Files",
                    vimgrep_arguments = {
                        "rg",
                        "--hidden",
                        "-L",
                        "--color=never",
                        "--sort=path",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                    },
                }
            end,
            desc = "Live grep in files (respect gitignored)",
        },
        {
            "<leader>G",
            function()
                require("telescope").extensions.live_grep_args.live_grep_args {
                    prompt_title = "Grep All Files",
                    vimgrep_arguments = {
                        "rg",
                        "--hidden",
                        "--no-ignore",
                        "-L",
                        "--color=never",
                        "--sort=path",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                    },
                }
            end,
            desc = "Live grep in all files  (include gitignored)",
        },
        {
            "<leader>b",
            function()
                require("telescope.builtin").buffers()
            end,
            desc = "List open buffers",
        },
        {
            "<leader>h",
            function()
                require("telescope.builtin").help_tags()
            end,
            desc = "Search help tags",
        },
        {
            "<leader>s",
            function()
                require("telescope.builtin").lsp_document_symbols()
            end,
            desc = "List document symbols",
        },
    },
    config = function()
        local actions = require "telescope.actions"

        require("telescope").setup {
            defaults = {
                path_display = { truncate = 1 },
                prompt_prefix = "   ",
                selection_caret = "  ",
                layout_config = {
                    prompt_position = "top",
                },
                preview = {
                    filesize_limit = 1,
                    timeout = 200,
                    msg_bg_fillchar = " ",
                },
                sorting_strategy = "ascending",
                mappings = {
                    i = {
                        ["<esc>"] = actions.close,
                        ["<C-Down>"] = actions.cycle_history_next,
                        ["<C-Up>"] = actions.cycle_history_prev,
                    },
                },
                file_ignore_patterns = { ".git/" },
            },
            extensions = {
                live_grep_args = {
                    mappings = {
                        i = {
                            ["<C-k>"] = require("telescope-live-grep-args.actions").quote_prompt(),
                            ["<C-space>"] = actions.to_fuzzy_refine,
                        },
                    },
                },
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown(),
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                },
                buffers = {
                    previewer = false,
                    layout_config = {
                        width = 80,
                    },
                },
                oldfiles = {
                    prompt_title = "History",
                },
                lsp_references = {
                    previewer = false,
                },
                lsp_definitions = {
                    previewer = false,
                },
                lsp_document_symbols = {
                    symbol_width = 55,
                },
            },
        }

        require("telescope").load_extension "fzf"
        require("telescope").load_extension "ui-select"
    end,
}
