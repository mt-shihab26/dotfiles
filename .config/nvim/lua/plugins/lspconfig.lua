-- LSP configuration

local intelephense = {
    enabled = true,
}

local gopls = {
    settings = {
        gopls = {
            gofumpt = true,
            codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
            },
            hints = {
                assignVariableTypes = false,
                compositeLiteralFields = false,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = false,
                rangeVariableTypes = true,
            },
            analyses = {
                fieldalignment = true,
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
            },
            usePlaceholders = true,
            completeUnimported = true,
            staticcheck = true,
            directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
            semanticTokens = true,
        },
    },
}

local templ = {
    enabled = true,
}

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

            -- php
            intelephense = intelephense,

            -- go
            gopls = gopls,
            templ = templ,
        },
        setup = {
            gopls = function(_, _)
                -- workaround for gopls not supporting semanticTokensProvider
                -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
                LazyVim.lsp.on_attach(function(client, _)
                    if not client.server_capabilities.semanticTokensProvider then
                        local semantic = client.config.capabilities.textDocument.semanticTokens
                        if semantic then
                            client.server_capabilities.semanticTokensProvider = {
                                full = true,
                                legend = {
                                    tokenTypes = semantic.tokenTypes,
                                    tokenModifiers = semantic.tokenModifiers,
                                },
                                range = true,
                            }
                        end
                    end
                end, "gopls")
                -- end workaround
            end,
        },
    },
    keys = {
        { "<leader>k", vim.diagnostic.open_float, desc = "hover diagnostics", mode = "n" },
    },
}
