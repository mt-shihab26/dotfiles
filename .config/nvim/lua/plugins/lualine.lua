return {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "lewis6991/gitsigns.nvim",
        "AndreM222/copilot-lualine",
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
                -- {
                --     "b:gitsigns_blame_line",
                --     cond = function()
                --         return vim.b.gitsigns_blame_line ~= nil
                --     end,
                --     fmt = function(str)
                --         -- Trim the string to show only author and date
                --         local blame = str:gsub("%s*%(.*%)%s*$", "")
                --         return blame
                --     end,
                -- },
            },
            lualine_x = {
                -- {
                --     "copilot",
                --     show_colors = true,
                --     show_loading = true,
                -- },
                "encoding",
                -- "fileformat",
                "filetype",
                {
                    function()
                        local buf_clients = vim.lsp.get_clients { bufnr = 0 }
                        if #buf_clients == 0 then
                            return ""
                        end

                        local buf_client_names = {}
                        for _, client in pairs(buf_clients) do
                            table.insert(buf_client_names, client.name)
                        end

                        return table.concat(buf_client_names, ", ")
                    end,
                    icon = "",
                },
            },
            lualine_y = {
                "diff",
                "diagnostics",
            },
            lualine_z = {
                "progress",
                "location",
            },
        },
    },
}
