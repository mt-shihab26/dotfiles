return {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "prev buffer (bufferline)" },
        { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "next buffer (bufferline)" },
        { "<leader>Q", "<cmd>bp<bar>sp<bar>bn<bar>bd<cr>", mode = "n", desc = "close current buffer (bufferline)" },
        { "<leader>q", require "utils.close_terminals_or_others", desc = "close terminals or other buffers (bufferline)" },
        { "<leader>cl", "<Cmd>BufferLineCloseRight<CR>", desc = "delete buffers to the right (bufferline)" },
        { "<leader>ch", "<Cmd>BufferLineCloseLeft<CR>", desc = "delete buffers to the left (bufferline)" },
    },
    opts = {
        options = {
            close_command = "bdelete! %d",
            right_mouse_command = "bdelete! %d",
            diagnostics = "nvim_lsp",
            diagnostics_update_in_insert = false,
            always_show_bufferline = false,
            mode = "buffers",
            numbers = "none",
            left_mouse_command = "buffer %d",
            middle_mouse_command = nil,
            modified_icon = "●",
            close_icon = "",
            left_trunc_marker = "",
            right_trunc_marker = "",
            show_buffer_icons = true,
            show_buffer_close_icons = true,
            show_close_icon = true,
            show_tab_indicators = true,
            separator_style = "thin",
            enforce_regular_tabs = false,
            exclude_ft = {
                "dashboard",
            },
            indicator = {
                icon = "▎",
                style = "icon",
            },
            offsets = {
                {
                    filetype = "neo-tree",
                    text = "File Tree",
                    highlight = "Directory",
                    text_align = "left",
                },
            },
        },
    },
}
