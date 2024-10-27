local ensure_installed = {
    "lua_ls", -- lua

    "dockerls", -- docker
    "docker_compose_language_service",

    "html", -- html

    "cssls", -- css
    "tailwindcss", -- tailwindcss

    "vtsls", -- typescript
    "astro", -- astro
    "volar", -- vue

    "intelephense", -- php

    "gopls", -- go
    "templ", -- templ

    "pyright", -- python

    "rust_analyzer", -- rust

    "clangd", -- c/cpp
}

local servers = {
    lua_ls = {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                },
                telemetry = { enable = false },
            },
        },
    },

    tailwindcss = {
        filetypes_exclude = { "markdown" },
        filetypes_include = {},
    },

    vtsls = {
        filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
        },
        settings = {
            complete_function_calls = true,
            vtsls = {
                enableMoveToFileCodeAction = true,
                autoUseWorkspaceTsdk = true,
                experimental = {
                    completion = {
                        enableServerSideFuzzyMatch = true,
                    },
                },
            },
            typescript = {
                updateImportsOnFileMove = { enabled = "always" },
                suggest = {
                    completeFunctionCalls = true,
                },
                inlayHints = {
                    enumMemberValues = { enabled = true },
                    functionLikeReturnTypes = { enabled = false },
                    parameterNames = { enabled = false }, -- "literals"
                    parameterTypes = { enabled = false },
                    propertyDeclarationTypes = { enabled = true },
                    variableTypes = { enabled = false },
                },
            },
        },
    },
    volar = {
        init_options = {
            vue = {
                hybridMode = true,
            },
        },
    },

    gopls = {
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
    },

    pyright = {
        settings = {
            python = {
                analysis = {
                    typeCheckingMode = "basic",
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true,
                },
            },
        },
    },
}

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        -- Automatically install LSPs and related tools to stdpath for neovim
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        -- Useful status updates for LSP
        { "j-hui/fidget.nvim", tag = "legacy" },
    },
    config = function()
        require("mason").setup {}

        require("mason-lspconfig").setup {
            ensure_installed = ensure_installed,
            automatic_installation = true,
        }

        -- Fidget setup for LSP loading progress
        require("fidget").setup {
            text = {
                spinner = "pipe",
            },
            window = {
                blend = 0,
            },
        }

        -- LSP settings
        local lspconfig = require "lspconfig"
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        -- Diagnostic signs with more distinctive icons
        local signs = {
            Error = "󰅚", --
            Warn = "󰀪", --
            Hint = "󰌶", --
            Info = "", --
        }

        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end

        -- Diagnostic configuration
        vim.diagnostic.config {
            virtual_text = true,
            signs = true,
            update_in_insert = false,
            underline = true,
            severity_sort = true,
            float = {
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        }

        -- LSP keybindings
        local on_attach = function(client, bufnr)
            local opts = { noremap = true, silent = true, buffer = bufnr }

            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
            vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
            vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
            vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
            vim.keymap.set("n", "<space>wl", function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, opts)
            vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
            vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
            vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "<space>f", function()
                vim.lsp.buf.format { async = true }
            end, opts)
        end

        -- Setup all servers
        for server_name, server_settings in pairs(servers) do
            lspconfig[server_name].setup(vim.tbl_deep_extend("force", {
                capabilities = capabilities,
                on_attach = on_attach,
            }, server_settings or {}))
        end
    end,
}
