local servers = {
    -- Lua
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

    -- Frontend
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
                    parameterNames = { enabled = false },
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

    -- Go
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

    -- Python
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

    -- Other languages with default settings
    dockerls = {},
    docker_compose_language_service = {},
    html = {},
    cssls = {},
    astro = {},
    intelephense = {},
    templ = {},
    rust_analyzer = {},
    clangd = {},
}

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        -- { "j-hui/fidget.nvim", tag = "legacy" },
    },
    config = function()
        require("mason").setup {}

        require("mason-lspconfig").setup {
            ensure_installed = vim.tbl_keys(servers),
            automatic_installation = true,
        }

        -- require("fidget").setup {
        --     text = {
        --         spinner = "pipe",
        --     },
        --     window = {
        --         blend = 0,
        --     },
        -- }

        -- LSP settings
        local lspconfig = require "lspconfig"
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        -- LSP keybindings
        local on_attach = function(_, bufnr)
            local opts = { noremap = true, silent = true, buffer = bufnr }

            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

            vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
            vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
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
