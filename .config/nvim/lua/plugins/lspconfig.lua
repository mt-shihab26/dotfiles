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

    -- HTML
    html = {},

    -- CSS
    cssls = {},
    tailwindcss = {
        filetypes_exclude = { "markdown" },
        filetypes_include = {},
    },

    -- Javascript
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
    astro = {},
    volar = {
        init_options = {
            vue = {
                hybridMode = true,
            },
        },
    },

    -- PHP
    intelephense = {},

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
    templ = {},

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

    -- RUST
    rust_analyzer = {},

    -- C/C++
    clangd = {},
}

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        { "j-hui/fidget.nvim", tag = "legacy" },
    },
    config = function()
        require("mason").setup {}

        require("mason-lspconfig").setup {
            ensure_installed = vim.tbl_keys(servers),
            automatic_installation = true,
        }

        require("fidget").setup {
            text = {
                spinner = "pipe",
            },
            window = {
                blend = 0,
            },
        }

        local lspconfig = require "lspconfig"
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        local on_attach = function(_, bufnr)
            local opts = function(opts)
                return vim.tbl_extend("force", {
                    noremap = true,
                    silent = true,
                    buffer = bufnr,
                }, opts or {})
            end

            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts { desc = "go to definition" })
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts { desc = "go to declaration" })
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts { desc = "go to references" })
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts { desc = "go to implementation" })

            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts { desc = "show hover documentation" })
            vim.keymap.set("n", "<C-k>", vim.diagnostic.open_float, opts { desc = "show hover diagnostics" })

            vim.keymap.set("n", "<leader>h", vim.lsp.buf.signature_help, opts { desc = "signature help" })
            vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts { desc = "code actions" })
            vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts { desc = "rename symbol" })

            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "go to prev diagnostic" })
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "go to next diagnostic" })
        end

        for server_name, server_settings in pairs(servers) do
            lspconfig[server_name].setup(vim.tbl_deep_extend("force", {
                capabilities = capabilities,
                on_attach = on_attach,
            }, server_settings or {}))
        end
    end,
}
