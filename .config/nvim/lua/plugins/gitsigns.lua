return {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    opts = {
        signs = {
            add = { text = "+" },
            change = { text = "~" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
            untracked = { text = "┆" },
        },
        signs_staged = {
            add = { text = "│" },
            change = { text = "≈" },
            delete = { text = "▁" },
            topdelete = { text = "▔" },
            changedelete = { text = "≋" },
            untracked = { text = "║" },
        },
        current_line_blame = true, -- Enable current line blame
        current_line_blame_opts = {
            virt_text = true,
            delay = 500,
        },
    },
}
