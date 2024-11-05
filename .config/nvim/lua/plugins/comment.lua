return {
    "numToStr/Comment.nvim",
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
        -- Load ts_context_commentstring first
        require("ts_context_commentstring").setup {
            enable_autocmd = false,
        }

        require("Comment").setup {
            pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            padding = true,
            sticky = true,
            mappings = {
                basic = true,
                extra = false,
            },
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
