return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                html = {},
                cssls = {},
                sqlls = {},
                gopls = {
                    settings = {
                        gopls = {
                            hints = {
                                assignVariableTypes = false,
                                compositeLiteralFields = false,
                                -- compositeLiteralTypes = false,
                                -- constantValues = false,
                                -- functionTypeParameters = false,
                                parameterNames = false,
                                -- rangeVariableTypes = false,
                            },
                        },
                    },
                },
                templ = {},
                vtsls = {
                    settings = {
                        typescript = {
                            inlayHints = {
                                -- enumMemberValues = { enabled = true },
                                -- functionLikeReturnTypes = { enabled = true },
                                parameterNames = { enabled = false },
                                parameterTypes = { enabled = false },
                                -- propertyDeclarationTypes = { enabled = true },
                                -- variableTypes = { enabled = false },
                            },
                        },
                    },
                },
            },
        },
    },
    {
        "olexsmir/gopher.nvim",
        ft = "go",
        build = function()
            vim.cmd.GoInstallDeps()
        end,
    },
}
