local lazy = require "lib.lazy"

-- loads on the first search and replace (<leader>s...) or :Spectre
lazy.add({
    {
        src = "https://github.com/nvim-pack/nvim-spectre",
        version = "master",
    },
}, {
    modules = { "spectre" },
    commands = { "Spectre" },
    setup = function()
        require("spectre").setup {}
    end,
})
