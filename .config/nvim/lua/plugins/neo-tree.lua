-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
    "nvim-neo-tree/neo-tree.nvim",
    version = "*",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
        { "<leader>e", "<cmd>Neotree action=focus<cr>", desc = "focus file tree", remap = true },
        { "<leader>p", "<cmd>Neotree action=close<cr>", desc = "close file tree", remap = true },
        { "<C-n>", "<cmd>Neotree toggle<cr>", desc = "toggle file tree", remap = true },
    },
    opts = {
        filesystem = {
            filtered_items = {
                hide_dotfiles = false,
                hide_gitignored = false,
            },
        },
    },
}
