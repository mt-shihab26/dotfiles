local config = function()
    vim.cmd.colorscheme "catppuccin-mocha"
end

return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = config,
    },
}
