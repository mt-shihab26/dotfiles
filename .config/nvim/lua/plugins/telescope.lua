return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = {
        {
            "<leader>f",
            function()
                require("telescope.builtin").find_files {
                    prompt_title = "Find Files",
                    no_ignore = false,
                    hidden = true,
                    respect_gitignore = true,
                    file_ignore_patterns = { "^.git/" },
                }
            end,
            desc = "Find files (respecting gitignore)",
        },
        {
            "<leader>F",
            function()
                require("telescope.builtin").find_files {
                    prompt_title = "Find All Files",
                    no_ignore = true,
                }
            end,
            desc = "Find all files (including gitignore)",
        },
        {
            "<leader>g",
            function()
                require("telescope.builtin").live_grep {
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
                    prompt_title = "Grep Files",
                }
            end,
            desc = "Grep files (respecting gitignore)",
        },
        {
            "<leader>G",
            function()
                require("telescope.builtin").live_grep {
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
                    prompt_title = "Grep All Files",
                }
            end,
            desc = "Grep all files (including gitignore)",
        },
    },
}
