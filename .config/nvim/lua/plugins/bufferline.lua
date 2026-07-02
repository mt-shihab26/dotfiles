vim.pack.add {
    {
        src = "https://github.com/akinsho/bufferline.nvim",
        version = vim.version.range "4",
    },
}

require("bufferline").setup {
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
}
