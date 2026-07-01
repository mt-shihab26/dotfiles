return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            -- Deferred so it runs after lazy finishes loading (no-op if parsers are current)
            vim.schedule(function()
                local ts = require "nvim-treesitter"
                if ts.install then
                    ts.install(require "lists.parsers")
                end
            end)

            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    pcall(vim.treesitter.start)
                    if args.match ~= "yaml" then
                        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                end,
            })

            vim.treesitter.language.register("markdown", "mdx")
            vim.treesitter.language.register("markdown", "markdown.mdx")
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
    },
    {
        "windwp/nvim-ts-autotag",
        event = { "BufReadPre", "BufNewFile" },
        opts = {},
    },
    {
        "folke/ts-comments.nvim",
        event = "VeryLazy",
    },
}
