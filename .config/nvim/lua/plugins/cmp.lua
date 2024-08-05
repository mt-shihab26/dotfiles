return {
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local cmp = require "cmp"
            cmp.setup {
                sources = {
                    { name = "nvim_lsp" },
                },
            }
        end,
    },
}
