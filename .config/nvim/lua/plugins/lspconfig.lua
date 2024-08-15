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
                cssls = {},
                gopls = {
                    settings = {
                        gopls = {
                            hints = {
                                -- assignVariableTypes = false,
                                -- compositeLiteralFields = false,
                                -- compositeLiteralTypes = false,
                                -- constantValues = false,
                                -- functionTypeParameters = false,
                                -- parameterNames = false,
                                -- rangeVariableTypes = flase,
                            },
                        },
                    },
                },
            },
        },
    },
}
