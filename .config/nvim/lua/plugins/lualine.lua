return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
        options = {
            section_separators = "",
            component_separators = "",
        },
        sections = {
            lualine_y = {
                { "location", padding = { left = 0, right = 1 } },
            },
            lualine_z = {
                { "progress", separator = " ", padding = { left = 1, right = 0 } },
            },
        },
    },
}
