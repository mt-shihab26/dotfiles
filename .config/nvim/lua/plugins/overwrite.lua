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
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "tokyonight-night",
        },
    },
    {
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
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        keys = {
            { "<leader>e", "<CMD>Neotree action=focus<CR>", desc = "Focus File Tree", remap = true },
            { "<leader>p", "<CMD>Neotree action=close<CR>", desc = "Close File Tree", remap = true },
            { "<C-n>", "<CMD>Neotree toggle<CR>", desc = "Toggle File Tree", remap = true },
        },
        opts = {
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = false,
                },
            },
        },
    },
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                php = { "pint" },
                blade = { "prettier" },
                svg = { "prettier" },
                markdown = { "prettier" },
                -- sql = { "sleek" },
                templ = { "templ" },
            },
        },
    },
    {
        "nvimdev/dashboard-nvim",
        opts = {
            theme = "hyper",
            config = {
                week_header = {
                    enable = true,
                },
                shortcut = {
                    {
                        action = "Lazy",
                        desc = " Lazy",
                        icon = "󰒲 ",
                        key = "l",
                        group = "Label",
                    },
                    {
                        action = "Mason",
                        desc = "Mason",
                        icon = " ",
                        key = "m",
                        group = "@property",
                    },
                    {
                        action = "lua LazyVim.pick.config_files()()",
                        desc = " Config",
                        icon = " ",
                        key = "c",
                        group = "@property",
                    },
                    {
                        action = function()
                            vim.api.nvim_input "<cmd>qa<cr>"
                        end,
                        desc = " Quit",
                        icon = " ",
                        key = "q",
                        group = "Label",
                    },
                },
            },
        },
    },
}
