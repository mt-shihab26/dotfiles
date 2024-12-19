return {
    {
        dir = "~/Code/sr.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("sr").setup {
                keymap = "<leader>sr",
                ignore_case = false,
                use_regex = false,
                preview_changes = true,
                live_preview = true,
            }
        end,
    },
    {
        "p-nerd/sr.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("sr").setup {
                keymap = "<leader>sr",
                ignore_case = false,
                use_regex = false,
                preview_changes = true,
                live_preview = true,
            }
        end,
    },
}
