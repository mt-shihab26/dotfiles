-- Fuzzy finder

return {
    "nvim-telescope/telescope.nvim",
    keys = {
        { "<leader>/", false },
        { "<leader>,", false },
        { "<leader>:", false },
        { "<leader><space>", false },
        -- find
        { "<leader>fb", false },
        { "<leader>fc", false },
        { "<leader>ff", false },
        { "<leader>fF", false },
        { "<leader>fg", false },
        { "<leader>fr", false },
        { "<leader>fR", false },
        -- git
        { "<leader>gc", false },
        { "<leader>gs", false },
        -- search
        { '<leader>s"', false },
        { "<leader>sa", false },
        { "<leader>sb", false },
        { "<leader>sc", false },
        { "<leader>sC", false },
        { "<leader>sd", false },
        { "<leader>sD", false },
        { "<leader>sg", false },
        { "<leader>sG", false },
        { "<leader>sh", false },
        { "<leader>sH", false },
        { "<leader>sj", false },
        { "<leader>sk", false },
        { "<leader>sl", false },
        { "<leader>sM", false },
        { "<leader>sm", false },
        { "<leader>so", false },
        { "<leader>sR", false },
        { "<leader>sq", false },
        { "<leader>sw", false },
        { "<leader>sW", false },
        { "<leader>sw", false },
        { "<leader>sW", false },
        { "<leader>uC", false },
        { "<leader>ss", false },
        { "<leader>sS", false },
        {
            "<leader>ff",
            function()
                require("telescope.builtin").find_files {
                    prompt_title = "Find Files",
                }
            end,
        },
        {
            "<leader>fF",
            function()
                require("telescope.builtin").find_files {
                    prompt_title = "Find All Files",
                    no_ignore = true,
                }
            end,
        },
        {
            "<leader>fg",
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
        },
        {
            "<leader>fG",
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
        },
    },
}
