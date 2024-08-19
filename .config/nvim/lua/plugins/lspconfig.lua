return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                intelephense = {
                    filetypes = { "php", "blade", "php_only" },
                    settings = {
                        intelephense = {
                            filetypes = { "php", "blade", "php_only" },
                            files = {
                                associations = { "*.php", "*.blade.php" }, -- Associating .blade.php files as well
                                maxSize = 5000000,
                            },
                        },
                    },
                },
                html = {},
                -- filetypes = { "html" }, -- this is {"html", "templ"} by default
                cssls = {},
                sqlls = {},
                templ = {},
            },
        },
    },
    {
        "olexsmir/gopher.nvim",
        ft = "go",
        -- (optional) will update plugin's deps on every update
        build = function()
            vim.cmd.GoInstallDeps()
        end,
        ---@type gopher.Config
        opts = {},
    },
}
