vim.pack.add {
    {
        src = "https://github.com/nvim-neo-tree/neo-tree.nvim",
        version = vim.version.range "3",
    },
    {
        src = "https://github.com/nvim-lua/plenary.nvim",
        version = vim.version.range "0.1",
    },
    {
        src = "https://github.com/MunifTanjim/nui.nvim",
        version = vim.version.range "0.4",
    },
    {
        src = "https://github.com/nvim-tree/nvim-web-devicons",
        version = "master",
    },
}

local neo_tree = require "neo-tree"

neo_tree.setup {
    default_component_configs = {
        file_size = { enabled = false },
        type = { enabled = false },
        last_modified = { enabled = false },
        created = { enabled = false },
    },
    filesystem = {
        use_libuv_file_watcher = true,
        hijack_netrw_behavior = "disabled",
        filtered_items = {
            visible = false,
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_hidden = false,
            always_show = { ".DS_Store" },
            never_show = { ".git" },
        },
        follow_current_file = {
            enabled = true,
            leave_dirs_open = true,
        },
    },
}
