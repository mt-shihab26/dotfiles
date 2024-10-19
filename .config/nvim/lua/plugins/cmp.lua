return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        { "roobert/tailwindcss-colorizer-cmp.nvim", opts = {} },
        { "petertriho/cmp-git", opts = {} },
    },
    ---@module 'cmp'
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
        -- git
        table.insert(opts.sources, { name = "git" })

        -- css
        -- original LazyVim kind icon formatter
        local format_kinds = opts.formatting.format
        opts.formatting.format = function(entry, item)
            format_kinds(entry, item) -- add icons
            return require("tailwindcss-colorizer-cmp").formatter(entry, item)
        end
    end,
}
