-- Display buffers as tabs.

return {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    version = "*",
    opts = {
        options = {
            mode = "buffers",
            numbers = "none",
            close_command = "bdelete! %d",
            right_mouse_command = "bdelete! %d",
            left_mouse_command = "buffer %d",
            middle_mouse_command = nil,
            indicator = {
                icon = "▎",
                style = "icon",
            },
            modified_icon = "●",
            close_icon = "",
            left_trunc_marker = "",
            right_trunc_marker = "",
            diagnostics = "nvim_lsp",
            diagnostics_update_in_insert = false,
            offsets = {
                {
                    filetype = "neo-tree",
                    text = "neo-tree",
                    highlight = "Directory",
                    text_align = "left",
                },
            },
            show_buffer_icons = true,
            show_buffer_close_icons = true,
            show_close_icon = true,
            show_tab_indicators = true,
            separator_style = "thin",
            enforce_regular_tabs = false,
            always_show_bufferline = true,
        },
    },
    keys = {
        { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "prev buffer" },
        { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "next buffer" },
        { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "delete other buffers" },
        { "<leader>bc", "<cmd>bp<bar>sp<bar>bn<bar>bd<cr>", mode = "n", desc = "close current buffer" },
    },
}
