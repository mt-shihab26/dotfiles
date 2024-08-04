local options = {
    user_default_options = {
        tailwind = true,
    },
}

local config = function()
    require("colorizer").setup(options)
end

return {
    {
        "NvChad/nvim-colorizer.lua",
        config = config,
    },
}
