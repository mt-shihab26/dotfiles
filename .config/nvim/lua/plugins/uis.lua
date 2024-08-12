return {
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            vim.opt.termguicolors = true
            require("bufferline").setup {}
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("lualine").setup {}
        end,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            require("which-key").setup {
                preset = "modern",
            }
        end,
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show { global = false }
                end,
                desc = "buffer local keymaps (which-key)",
            },
        },
    },
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
                update_focused_file = {
                    enable = true,
                    update_root = false,
                },
                view = {
                    width = 36,
                    number = true,
                    relativenumber = true,
                },
                renderer = {
                    highlight_git = true,
                    indent_markers = {
                        enable = true,
                    },
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
    {
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("dashboard").setup {
                theme = "hyper",
                config = {
                    week_header = {
                        enable = true,
                    },
                    shortcut = {
                        {
                            desc = "󰊳 Update",
                            group = "@property",
                            action = "Lazy update",
                            key = "u",
                        },
                        {
                            desc = " Files",
                            group = "Label",
                            action = "TelescopeProjectFiles",
                            key = "f",
                            icon_hl = "@variable",
                        },
                        {
                            desc = "🌲Tree",
                            group = "Label",
                            action = "NvimTreeToggle",
                            key = "t",
                        },
                        {
                            desc = " Mason",
                            group = "@property",
                            action = "Mason",
                            key = "m",
                        },
                    },
                },
            }
        end,
    },
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require("toggleterm").setup {
                direction = "float",
            }
        end,
    },
    {
        "razak17/tailwind-fold.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        event = "VeryLazy",
        config = function()
            require("tailwind-fold").setup {
                ft = {
                    "html",
                    "astro",
                    "vue",
                    "typescriptreact",
                    "javascriptreact",
                    "php",
                    "blade",
                },
            }
        end,
    },
}
