-- Fuzzy finder

local function vimgrep_arguments()
    local vg = { unpack(require("telescope.config").values.vimgrep_arguments) }
    -- I want to search in hidden/dot files.
    table.insert(vg, "--hidden")
    -- I don't want to search in the `.git` directory.
    table.insert(vg, "--glob")
    table.insert(vg, "!**/.git/*")
    return vg
end

return {
    "nvim-telescope/telescope.nvim",
    opts = {
        defaults = {
            layout_strategy = "horizontal",
            layout_config = { prompt_position = "top" },
            sorting_strategy = "ascending",
            winblend = 0,
            vimgrep_arguments = vimgrep_arguments(),
        },
    },
}
