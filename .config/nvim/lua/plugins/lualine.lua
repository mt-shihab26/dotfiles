return {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "lewis6991/gitsigns.nvim",
    },
    opts = {
        options = {
            section_separators = "",
            component_separators = "",
            globalstatus = true,
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = {
                {
                    "filename",
                    path = 1, -- Show relative path
                    file_status = true,
                    newfile_status = true,
                    symbols = {
                        modified = "[+]",
                        readonly = "[-]",
                        unnamed = "[No Name]",
                        newfile = "[New]",
                    },
                },
            },
            lualine_c = {
                {
                    "b:gitsigns_blame_line",
                    cond = function()
                        return vim.b.gitsigns_blame_line ~= nil
                    end,
                    fmt = function(str)
                        -- Trim the string to show only author and date
                        local blame = str:gsub("%s*%(.*%)%s*$", "")
                        return blame
                    end,
                },
            },
            lualine_x = { "encoding", "fileformat", "filetype" },
            lualine_y = { "diff", "diagnostics" },
            lualine_z = { "progress", "location" },
        },
    },
}
