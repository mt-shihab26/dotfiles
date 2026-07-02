vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        if ev.data.spec.name == "telescope-fzf-native.nvim" and vim.fn.executable "make" == 1 then
            vim.system({ "make" }, { cwd = ev.data.path }):wait()
        end
    end,
})

vim.pack.add {
    {
        src = "https://github.com/nvim-telescope/telescope.nvim",
        version = "master",
    },
    "https://github.com/nvim-telescope/telescope-live-grep-args.nvim",
    "https://github.com/nvim-telescope/telescope-ui-select.nvim",
    "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
}

local actions = require "telescope.actions"

require("telescope").setup {
    defaults = {
        path_display = { truncate = 1 },
        prompt_prefix = "   ",
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
                ["<M-n>"] = actions.move_selection_next,
                ["<M-p>"] = actions.move_selection_previous,
                ["<M-y>"] = actions.select_default,
            },
        },
        file_ignore_patterns = { ".git/" },
    },
    extensions = {
        live_grep_args = {
            mappings = {
                i = {
                    ["<C-k>"] = function(...)
                        return require("telescope-live-grep-args.actions").quote_prompt()(...)
                    end,
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

local fzf_plugins = vim.pack.get { "telescope-fzf-native.nvim" }
if #fzf_plugins > 0 then
    local so = fzf_plugins[1].path .. "/build/libfzf.so"
    if vim.fn.filereadable(so) == 0 and vim.fn.executable "make" == 1 then
        vim.system({ "make" }, { cwd = fzf_plugins[1].path }):wait()
    end
end

require("telescope").load_extension "fzf"
require("telescope").load_extension "ui-select"
