local M = {}

function M.find_files()
    require("telescope.builtin").find_files { prompt_title = "Find Files" }
end

function M.find_all_files()
    require("telescope.builtin").find_files { prompt_title = "Find All Files", no_ignore = true }
end

function M.grep_files()
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
            "--glob=!.git/*",
            "--glob=!composer.lock",
            "--glob=!pnpm-lock.yaml",
            "--glob=!package-lock.json",
            "--glob=!yarn.lock",
        },
    }
end

function M.grep_all_files()
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
end

function M.help_tags()
    require("telescope.builtin").help_tags()
end

function M.lsp_document_symbols()
    require("telescope.builtin").lsp_document_symbols()
end

return M
