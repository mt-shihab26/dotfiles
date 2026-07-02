vim.pack.add {
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
    { src = "https://github.com/AndreM222/copilot-lualine" },
}

require("lualine").setup {
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
                path = 1,
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
        lualine_c = {},
        lualine_x = {
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

                    local lsp_names = table.concat(buf_client_names, " ")
                    return " " .. lsp_names
                end,
                cond = function()
                    return #vim.lsp.get_clients { bufnr = 0 } > 0
                end,
            },
            "filetype",
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
}
