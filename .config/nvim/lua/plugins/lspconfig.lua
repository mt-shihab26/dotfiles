-- LSP configuration

-- css

local html = {}

local cssls = {}

local tailwindcss = {
    -- exclude a filetype from the default_config
    filetypes_exclude = { "markdown" },
    -- add additional filetypes to the default_config
    filetypes_include = {},
    -- to fully override the default_config, change the below
    -- filetypes = {}
}

local tailwindcss_setup = function(_, opts)
    --- @type any
    local tw = LazyVim.lsp.get_raw_config "tailwindcss"
    opts.filetypes = opts.filetypes or {}

    -- Add default filetypes
    vim.list_extend(opts.filetypes, tw.default_config.filetypes)

    -- Remove excluded filetypes
    --- @param ft string
    opts.filetypes = vim.tbl_filter(function(ft)
        return not vim.tbl_contains(opts.filetypes_exclude or {}, ft)
    end, opts.filetypes)

    -- Additional settings for Phoenix projects
    opts.settings = {
        tailwindCSS = {
            includeLanguages = {
                elixir = "html-eex",
                eelixir = "html-eex",
                heex = "html-eex",
            },
        },
    }
    -- Add additional filetypes
    vim.list_extend(opts.filetypes, opts.filetypes_include or {})
end

-- php

local intelephense = {
    enabled = true,
}

-- go

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

local gopls_setup = function(_, _)
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
end

local templ = {
    enabled = true,
}

return {
    "neovim/nvim-lspconfig",
    opts = {
        servers = {
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

            -- css
            html = html,
            cssls = cssls,
            tailwindcss = tailwindcss,

            -- php
            intelephense = intelephense,

            -- go
            gopls = gopls,
            templ = templ,
        },
        setup = {
            -- css
            tailwindcss = tailwindcss_setup,

            -- go
            gopls = gopls_setup,
        },
    },
    keys = {
        { "<leader>k", vim.diagnostic.open_float, desc = "hover diagnostics", mode = "n" },
    },
}
