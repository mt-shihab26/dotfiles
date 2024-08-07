return {
    {
        "NvChad/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup {
                user_default_options = {
                    tailwind = true,
                },
            }
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            local highlight = {
                "RainbowRed",
                "RainbowYellow",
                "RainbowBlue",
                "RainbowOrange",
                "RainbowGreen",
                "RainbowViolet",
                "RainbowCyan",
            }
            local hooks = require "ibl.hooks"
            -- create the highlight groups in the highlight setup hook, so they are reset
            -- every time the colorscheme changes
            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
                vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
                vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
                vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
                vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
                vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
                vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
            end)

            vim.g.rainbow_delimiters = { highlight = highlight }

            require("ibl").setup {
                scope = {
                    highlight = highlight,
                },
                exclude = {
                    filetypes = {
                        "dashboard",
                    },
                },
            }

            hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
        end,
    },
    {
        "folke/tokyonight.nvim",
        config = function()
            require("tokyonight").setup {}
        end,
    },
    {
        "catppuccin/nvim",
        lazy = true,
        name = "catppuccin",
        config = function()
            require("catppuccin").setup {}
        end,
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require("rose-pine").setup {}
        end,
    },
    {
        "0xstepit/flow.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            require("flow").setup {
                transparent = true,
                fluo_color = "green", --  pink, yellow, orange, green
                mode = "normal", -- normal, bright, desaturate, dark
                aggressive_spell = false,
            }
        end,
    },
    {
        "Mofiqul/dracula.nvim",
        config = function()
            require("catppuccin").setup {}
        end,
    },
    {
        "craftzdog/solarized-osaka.nvim",
        config = function()
            require("solarized-osaka").setup {
                transparent = false,
            }
        end,
    },
    {
        "zaldih/themery.nvim",
        config = function()
            require("themery").setup {
                themes = {
                    "tokyonight",
                    "tokyonight-night",
                    "tokyonight-storm",
                    "tokyonight-day",
                    "tokyonight-moon",
                    "catppuccin",
                    "catppuccin-latte",
                    "catppuccin-frappe",
                    "catppuccin-macchiato",
                    "catppuccin-mocha",
                    "rose-pine-main",
                    "rose-pine-moon",
                    "rose-pine-dawn",
                    "flow",
                    "dracula",
                    "dracula-soft",
                    "solarized-osaka",
                },
                livePreview = true,
            }
        end,
    },
}
