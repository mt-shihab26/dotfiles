local options = {
    options = {
        theme = "dracula",
    },
}

local config = function()
    require("lualine").setup(options)
end

return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = config,
    },
}
