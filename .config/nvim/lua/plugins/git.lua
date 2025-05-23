return {
    {
        "sindrets/diffview.nvim",
        keys = {
            { "<leader>d", "<cmd>DiffviewOpen<cr>", desc = "open git diff view (diffview)", remap = true },
        },
    },
    {
        "tpope/vim-fugitive",
    },
    {
        "lewis6991/gitsigns.nvim",
        lazy = false,
        keys = {
            { "]h", ":silent Gitsigns next_hunk<CR>", { desc = "navigate to the next git hunk (gitsigns)" } },
            { "[h", ":silent Gitsigns prev_hunk<CR>", { desc = "navigate to the previous git hunk (gitsigns)" } },
        },
        opts = {
            preview_config = {
                border = { "", "", "", " " },
            },
            current_line_blame = true,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
                ignore_whitespace = false,
            },
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "┄" },
                untracked = { text = "┆" },
            },
            signs_staged = {
                add = { text = "│" },
                change = { text = "≈" },
                delete = { text = "▁" },
                topdelete = { text = "▔" },
                changedelete = { text = "┈" },
                untracked = { text = "║" },
            },
        },
    },
}
