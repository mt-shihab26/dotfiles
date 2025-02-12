return {
    "nvim-pack/nvim-spectre",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        vim.keymap.set("n", "<leader>s", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
            desc = "search on current buffer (spectre)",
        })
        vim.keymap.set("n", "<leader>S", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
            desc = "search on multi buffers (spectre)",
        })
        vim.keymap.set("v", "<leader>S", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
            desc = "search on multi buffers (spectre)",
        })
    end,
}
