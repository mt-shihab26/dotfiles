--- Floating terminal

return {
    "voldikss/vim-floaterm",
    cmd = { "FloatermToggle" },
    init = function()
        vim.g.floaterm_width = 0.8
        vim.g.floaterm_height = 0.8
    end,
    keys = {
        { "<C-t>", "<cmd>FloatermToggle<cr>", desc = "toggle floating terminal" },
        { "<C-t>", "<Esc>:FloatermToggle<cr>", desc = "toggle floating terminal", mode = "i" },
        { "<C-t>", "<C-\\><C-n>:FloatermToggle<cr>", desc = "toggle floating terminal", mode = "t" },
    },
}
