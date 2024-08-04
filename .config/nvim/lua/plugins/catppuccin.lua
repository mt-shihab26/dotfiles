local catppuccin = {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        vim.cmd [[colorscheme catppuccin]]
    end,
}

local tokyodark = {
    "tiagovla/tokyodark.nvim",
    config = function()
        vim.cmd [[colorscheme tokyodark]]
    end,
}

return {
    catppuccin,
    -- tokyodark,
}
