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
    keys = {
        { "<leader>/", false },
        { "<leader>,", false },
        { "<leader>:", false },
        { "<leader><space>", false },
        -- find
        { "<leader>fb", false },
        { "<leader>fc", false },
        { "<leader>ff", false },
        { "<leader>fF", false },
        { "<leader>fg", false },
        { "<leader>fr", false },
        { "<leader>fR", false },
        -- git
        { "<leader>gc", false },
        { "<leader>gs", false },
        -- search
        { '<leader>s"', false },
        { "<leader>sa", false },
        { "<leader>sb", false },
        { "<leader>sc", false },
        { "<leader>sC", false },
        { "<leader>sd", false },
        { "<leader>sD", false },
        { "<leader>sg", false },
        { "<leader>sG", false },
        { "<leader>sh", false },
        { "<leader>sH", false },
        { "<leader>sj", false },
        { "<leader>sk", false },
        { "<leader>sl", false },
        { "<leader>sM", false },
        { "<leader>sm", false },
        { "<leader>so", false },
        { "<leader>sR", false },
        { "<leader>sq", false },
        { "<leader>sw", false },
        { "<leader>sW", false },
        { "<leader>sw", false },
        { "<leader>sW", false },
        { "<leader>uC", false },
        { "<leader>ss", false },
        { "<leader>sS", false },
    },
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
