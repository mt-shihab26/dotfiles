-- Fuzzy finder

return {
    "nvim-telescope/telescope.nvim",
    keys = {
        { "<leader>/", false },
        { "<leader>,", false },
        { "<leader>:", false },
        { "<leader><space>", false },
        { "<leader>fb", false },
        { "<leader>fc", false },
        { "<leader>fg", false },
        { "<leader>fr", false },
        { "<leader>fR", false },
        { "<leader>gc", false },
        { "<leader>gs", false },
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
            desc = "find files",
        },
        {
            "<leader>fF",
            function()
                require("telescope.builtin").find_files {
                    prompt_title = "Find All Files",
                    no_ignore = true,
                }
            end,
            desc = "find all files",
        },
        {
            "<leader>fg",
            function()
                require("telescope.builtin").live_grep {
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
                        "--glob=!.git/*",
                        "--glob=!composer.lock",
                        "--glob=!pnpm-lock.yaml",
                        "--glob=!package-lock.json",
                        "--glob=!yarn.lock",
                    },
                }
            end,
            desc = "grep files",
        },
        {
            "<leader>fG",
            function()
                require("telescope.builtin").live_grep {
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
            desc = "grep all files",
        },
    },
}
