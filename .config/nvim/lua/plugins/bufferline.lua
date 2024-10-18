local inactiveBg = {
    bg = { attribute = "bg", highlight = "BufferlineInactive" },
}

return {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
        options = {
            offsets = {
                {
                    filetype = "neo-tree",
                    text = "Neo-tree",
                    highlight = "Directory",
                    text_align = "left",
                },
            },
            diagnostics_indicator = function(count, level, diagnostics_dict, context)
                local s = " "
                for e, n in pairs(diagnostics_dict) do
                    local sym = e == "error" and " " or (e == "warning" and " " or " ")
                    s = s .. n .. sym
                end
                return s
            end,
        },
        highlights = {
            fill = {
                bg = { attribute = "bg", highlight = "StatusLine" },
            },
            background = inactiveBg,
            close_button = inactiveBg,
            diagnostic = inactiveBg,
            diagnostic_visible = inactiveBg,
            modified = inactiveBg,
            modified_visible = inactiveBg,
            hint = inactiveBg,
            hint_visible = inactiveBg,
            info = inactiveBg,
            info_visible = inactiveBg,
            warning = inactiveBg,
            warning_visible = inactiveBg,
            error = inactiveBg,
            error_visible = inactiveBg,
            hint_diagnostic = inactiveBg,
            hint_diagnostic_visible = inactiveBg,
            info_diagnostic = inactiveBg,
            info_diagnostic_visible = inactiveBg,
            warning_diagnostic = inactiveBg,
            warning_diagnostic_visible = inactiveBg,
            error_diagnostic = inactiveBg,
            error_diagnostic_visible = inactiveBg,
            duplicate = inactiveBg,
            duplicate_visible = inactiveBg,
            separator = {
                fg = { attribute = "bg", highlight = "StatusLine" },
                bg = { attribute = "bg", highlight = "BufferlineInactive" },
            },
            separator_selected = {
                fg = { attribute = "bg", highlight = "StatusLine" },
            },
            separator_visible = {
                fg = { attribute = "bg", highlight = "StatusLine" },
            },
            trunc_marker = {
                bg = { attribute = "bg", highlight = "StatusLine" },
            },

            -- Tabs
            tab = inactiveBg,
            tab_separator = {
                fg = { attribute = "bg", highlight = "StatusLine" },
                bg = { attribute = "bg", highlight = "BufferlineInactive" },
            },
            tab_separator_selected = {
                fg = { attribute = "bg", highlight = "StatusLine" },
            },
            tab_close = {
                bg = "yellow",
            },
        },
    },
    config = function(_, opts)
        require("bufferline").setup(opts)
        -- Fix bufferline when restoring a session
        vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
            callback = function()
                vim.schedule(function()
                    pcall(nvim_bufferline)
                end)
            end,
        })
        require("which-key").add {
            { "<leader>b", group = "Buffer management" },
        }
    end,
    keys = {
        { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
        { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
        { "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", desc = "Delete Buffers to the Left" },
        { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Delete Other Buffers" },
        { "<leader>br", "<cmd>BufferLineCloseRight<cr>", desc = "Delete Buffers to the Right" },
        -- { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
        -- { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
        -- { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
        -- { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
        -- { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
        -- { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
    },
}
