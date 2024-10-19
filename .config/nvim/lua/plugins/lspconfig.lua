-- LSP configuration

return {
    "neovim/nvim-lspconfig",
    opts = {
        servers = {
            html = {},
            cssls = {},
            vtsls = {
                settings = {
                    typescript = {
                        inlayHints = {
                            -- enumMemberValues = { enabled = true },
                            functionLikeReturnTypes = { enabled = false },
                            parameterNames = { enabled = false },
                            parameterTypes = { enabled = false },
                            -- propertyDeclarationTypes = { enabled = true },
                            -- variableTypes = { enabled = false },
                        },
                    },
                },
            },

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
        },
    },
    keys = {
        { "<leader>k", vim.diagnostic.open_float, desc = "hover diagnostics", mode = "n" },
    },
}
