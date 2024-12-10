return {
    "stevearc/oil.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
        default_file_explorer = true,
        view_options = {
            show_hidden = true,
        },
    },
    keys = {
        { "<leader>o", "<CMD>Oil<CR>", desc = "open oli plugin" },
    },
}
