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

        -- spectre colors the whole search and replace lines with a background (DiffChange/DiffDelete), which hides
        -- the visual selection on them, so selecting part of the text looks like the full line is selected; color
        -- the text instead. Set again on every colorscheme change, as :colorscheme clears them
        local function set_hl()
            vim.api.nvim_set_hl(0, "SpectreSearch", { link = "Removed" })
            vim.api.nvim_set_hl(0, "SpectreReplace", { link = "Added" })
        end
        set_hl()
        vim.api.nvim_create_autocmd("ColorScheme", { callback = set_hl })
    end,
})
