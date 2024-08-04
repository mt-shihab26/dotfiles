local config = function()
    vim.cmd [[colorscheme catppuccin]]
end

return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = config,
    },
}
