return {
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        cmd = {
            "NvimTreeToggle",
            "NvimTreeFocus",
            "NvimTreeClose",
        },
        config = function()
            require("nvim-tree").setup {
                filters = {
                    enable = false,
                },
                view = {
                    width = 40,
                },
                renderer = {
                    root_folder_label = false,
                    highlight_git = true,
                    indent_markers = { enable = true },
                    icons = {
                        glyphs = {
                            default = "󰈚",
                            folder = {
                                default = "",
                                empty = "",
                                empty_open = "",
                                open = "",
                                symlink = "",
                            },
                            git = { unmerged = "" },
                        },
                    },
                },
            }
        end,
    },
}
