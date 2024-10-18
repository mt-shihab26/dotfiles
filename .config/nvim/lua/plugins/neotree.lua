return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    opts = {
        close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        filesystem = {
            filtered_items = {
                hide_dotfiles = false,
                hide_gitignored = false,
            },
            follow_current_file = {
                enabled = true, -- This will find and focus the file in the active buffer every time
                leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
            },
        },
        window = {
            position = "left",
            width = 40,
            mapping_options = {
                noremap = true,
                nowait = true,
            },
        },
        event_handlers = {
            {
                event = "before_render",
                handler = function(_)
                    vim.cmd "noautocmd"
                end,
            },
        },
    },
    keys = {
        { "<leader>e", "<cmd>Neotree action=focus<cr>", desc = "Focus File Tree", remap = true },
        { "<leader>p", "<cmd>Neotree action=close<cr>", desc = "Close File Tree", remap = true },
        { "<C-n>", "<cmd>Neotree toggle<cr>", desc = "Toggle File Tree", remap = true },
    },
}
