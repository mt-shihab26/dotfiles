return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        init = function()
            vim.cmd.colorscheme "tokyonight-night"
            -- vim.cmd.colorscheme "tokyonight-day"
        end,
    },
    {
        "NvChad/nvim-colorizer.lua",
        opts = {
            user_default_options = {
                names = false,
                tailwind = true,
            },
        },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            scope = {
                show_start = false,
            },
            exclude = {
                filetypes = {
                    "dashboard",
                },
            },
        },
    },

    {
        "xiyaowong/transparent.nvim",
        -- enabled = false,
        config = function()
            require("transparent").setup {
                groups = {
                    "Normal",
                    "NormalNC",
                    -- "Comment",
                    -- "Constant",
                    -- "Special",
                    -- "Identifier",
                    -- "Statement",
                    -- "PreProc",
                    -- "Type",
                    -- "Underlined",
                    -- "Todo",
                    -- "String",
                    -- "Function",
                    -- "Conditional",
                    -- "Repeat",
                    -- "Operator",
                    -- "Structure",
                    -- "LineNr",
                    -- "NonText",
                    -- "SignColumn",
                    -- "CursorLine",
                    -- "CursorLineNr",
                    -- "StatusLine",
                    -- "StatusLineNC",
                    -- "EndOfBuffer",

                    "NeoTreeNormal",
                    "NeoTreeNormalNC",
                    -- "NeoTreeVertSplit",
                    -- "NeoTreeWinSeparator",
                    -- "NeoTreeEndOfBuffer",
                    -- "NeoTreeRootName",
                    -- "NeoTreeDirectoryName",
                    -- "NeoTreeDirectoryIcon",
                    -- "NeoTreeFileName",
                    -- "NeoTreeFileIcon",
                    -- "NeoTreeFloatNormal",
                    -- "NeoTreeFloatBorder",
                    --
                    "TelescopeNormal",
                    -- "TelescopeBorder",
                    -- "TelescopePromptNormal",
                    -- "TelescopePromptBorder",
                    -- "TelescopePromptTitle",
                    -- "TelescopePreviewTitle",
                    -- "TelescopeResultsTitle",
                    -- "TelescopePreviewNormal",
                    -- "TelescopePreviewBorder",
                    -- "TelescopeResultsNormal",
                    -- "TelescopeResultsBorder",
                    -- "TelescopeSelection",
                    -- "TelescopeMatching",
                },
                extra_groups = {},
                exclude_groups = {},
                on_clear = function() end,
            }

            vim.cmd "TransparentEnable"
        end,
    },
}
