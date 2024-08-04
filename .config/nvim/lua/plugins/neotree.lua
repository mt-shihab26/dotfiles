local options = {
    filesystem = {
        filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_hidden = false, -- only works on Windows for hidden files/directories
        },
        window = {
            width = 40,
        },
    },
}

local config = function()
    local neotree = require "neo-tree"

    neotree.setup(options)

    vim.keymap.set("n", "<leader>e", ":Neotree filesystem action=focus reveal<CR>", {})
    vim.keymap.set("n", "<leader>p", ":Neotree filesystem action=close reveal<CR>", {})
    vim.keymap.set("n", "<C-n>", ":Neotree filesystem toggle reveal<CR>", {})
end

return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        config = config,
    },
}
