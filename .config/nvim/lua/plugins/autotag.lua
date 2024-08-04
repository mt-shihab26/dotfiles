local ft = {
    "html",
    "php",
    "blade",
    "twig",
    "javascriptreact",
    "typescriptreact",
}

local config = function()
    require("nvim-ts-autotag").setup {}
end

return {
    {
        "windwp/nvim-ts-autotag",
        ft = ft,
        config = config,
    },
}
