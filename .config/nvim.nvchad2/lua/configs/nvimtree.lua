local nvimtree = require "nvchad.configs.nvimtree"

nvimtree.view.width = 40

nvimtree.filters.dotfiles = false
nvimtree.filters.git_clean = false
nvimtree.filters.no_buffer = false
nvimtree.filters.custom = { "node_modules" }

nvim_tree.setup {
    update_cwd = true,
    open_on_setup = true,
    open_on_setup_file = true,
    actions = {
        open_file = {
            resize_window = true,
        },
    },
    view = {
        side = "left",
    },
    update_focused_file = {
        enable = true,
        update_cwd = true,
    },
    filters = {
        dotfiles = false,
    },
    diagnostics = {
        enable = true,
    },
}
