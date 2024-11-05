return {
    "numToStr/Comment.nvim",
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
        require("ts_context_commentstring").setup {}

        require("Comment").setup {
            pre_hook = function()
                return vim.bo.commentstring
            end,
        }
    end,
    keys = {
        {
            "<leader>/",
            function()
                require("Comment.api").toggle.linewise.current()
            end,
            desc = "toggle comment line",
        },
        {
            "<leader>/",
            "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
            mode = "x",
            desc = "toggle comment line",
        },
    },
}
