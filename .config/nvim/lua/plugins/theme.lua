return {
    {
        "folke/tokyonight.nvim",
        enabled = true,
        lazy = false,
        priority = 1000,
        opts = {},
        init = function()
            vim.cmd.colorscheme "tokyonight-night"
            -- vim.cmd.colorscheme "tokyonight-day"
        end,
    },
    {
        "xiyaowong/transparent.nvim",
        -- enabled = false,
        config = function()
            require("transparent").setup {
                groups = {
                    "Normal",
                    "NormalNC",
                    "NeoTreeNormal",
                    "NeoTreeNormalNC",
                    "TelescopeNormal",
                    "TelescopeBorder",
                    "TelescopePromptNormal",
                    "TelescopePromptBorder",
                    "TelescopePromptTitle",
                    "TelescopePreviewTitle",
                    "TelescopeResultsTitle",
                    "TelescopePreviewNormal",
                    "TelescopePreviewBorder",
                    "TelescopeResultsNormal",
                    "TelescopeResultsBorder",
                    "TelescopeMatching",
                },
                extra_groups = {},
                exclude_groups = {},
                on_clear = function() end,
            }
            vim.cmd "TransparentEnable"
        end,
    },
}
