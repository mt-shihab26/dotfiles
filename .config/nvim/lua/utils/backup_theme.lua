local M = {}

function M.setup()
    vim.pack.add {
        {
            src = "https://github.com/folke/tokyonight.nvim",
            version = vim.version.range "4",
        },
        -- {
        --     src = "https://github.com/xiyaowong/transparent.nvim",
        -- },
    }

    -- require("transparent").setup {
    --     groups = {
    --         "Normal",
    --         "NormalNC",
    --         "NeoTreeNormal",
    --         "NeoTreeNormalNC",
    --         "TelescopeNormal",
    --         "TelescopeBorder",
    --         "TelescopePromptNormal",
    --         "TelescopePromptBorder",
    --         "TelescopePromptTitle",
    --         "TelescopePreviewTitle",
    --         "TelescopeResultsTitle",
    --         "TelescopePreviewNormal",
    --         "TelescopePreviewBorder",
    --         "TelescopeResultsNormal",
    --         "TelescopeResultsBorder",
    --         "TelescopeMatching",
    --     },
    --     extra_groups = {},
    --     exclude_groups = {},
    --     on_clear = function() end,
    -- }
    -- vim.g.transparent_enabled = true
end

function M.apply()
    pcall(vim.cmd.colorscheme, "tokyonight-night")
end

return M
