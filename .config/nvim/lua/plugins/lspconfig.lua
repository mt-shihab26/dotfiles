-- LSP configuration

-- css

local html = {
    --
}

local cssls = {
    --
}

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

-- javascript

local vtsls = {
    -- explicitly add default filetypes, so that we can extend
    -- them in related extras
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
    keys = {
        {
            "gD",
            function()
                local params = vim.lsp.util.make_position_params()
                LazyVim.lsp.execute {
                    command = "typescript.goToSourceDefinition",
                    arguments = { params.textDocument.uri, params.position },
                    open = true,
                }
            end,
            desc = "Goto Source Definition",
        },
        {
            "gR",
            function()
                LazyVim.lsp.execute {
                    command = "typescript.findAllFileReferences",
                    arguments = { vim.uri_from_bufnr(0) },
                    open = true,
                }
            end,
            desc = "File References",
        },
        {
            "<leader>co",
            LazyVim.lsp.action["source.organizeImports"],
            desc = "Organize Imports",
        },
        {
            "<leader>cM",
            LazyVim.lsp.action["source.addMissingImports.ts"],
            desc = "Add missing imports",
        },
        {
            "<leader>cu",
            LazyVim.lsp.action["source.removeUnused.ts"],
            desc = "Remove unused imports",
        },
        {
            "<leader>cD",
            LazyVim.lsp.action["source.fixAll.ts"],
            desc = "Fix all diagnostics",
        },
        {
            "<leader>cV",
            function()
                LazyVim.lsp.execute { command = "typescript.selectTypeScriptVersion" }
            end,
            desc = "Select TS workspace version",
        },
    },
}

local vtsls_setup = function(_, opts)
    LazyVim.lsp.on_attach(function(client, _)
        client.commands["_typescript.moveToFileRefactoring"] = function(command, _)
            ---@type any, any, any --@type string, string, lsp.Range
            local action, uri, range = unpack(command.arguments)

            local function move(newf)
                client.request("workspace/executeCommand", {
                    command = command.command,
                    arguments = { action, uri, range, newf },
                })
            end

            local fname = vim.uri_to_fname(uri)
            client.request("workspace/executeCommand", {
                command = "typescript.tsserverRequest",
                arguments = {
                    "getMoveToRefactoringFileSuggestions",
                    {
                        file = fname,
                        startLine = range.start.line + 1,
                        startOffset = range.start.character + 1,
                        endLine = range["end"].line + 1,
                        endOffset = range["end"].character + 1,
                    },
                },
            }, function(_, result)
                ---@type string[]
                local files = result.body.files
                table.insert(files, 1, "Enter new path...")
                vim.ui.select(files, {
                    prompt = "Select move destination:",
                    format_item = function(f)
                        return vim.fn.fnamemodify(f, ":~:.")
                    end,
                }, function(f)
                    if f and f:find "^Enter new path" then
                        vim.ui.input({
                            prompt = "Enter move destination:",
                            default = vim.fn.fnamemodify(fname, ":h") .. "/",
                            completion = "file",
                        }, function(newf)
                            return newf and move(newf)
                        end)
                    elseif f then
                        move(f)
                    end
                end)
            end)
        end
    end, "vtsls")
    -- copy typescript settings to javascript
    opts.settings.javascript =
        vim.tbl_deep_extend("force", {}, opts.settings.typescript, opts.settings.javascript or {})
end

local astro = {
    --
}

local astro_setup = function(_, _) -- opts
    -- LazyVim.extend(opts.servers.vtsls, "settings.vtsls.tsserver.globalPlugins", {
    --     {
    --         name = "@astrojs/ts-plugin",
    --         location = LazyVim.get_pkg_path("astro-language-server", "/node_modules/@astrojs/ts-plugin"),
    --         enableForWorkspaceTypeScriptVersions = true,
    --     },
    -- })
end

local volar = {
    init_options = {
        vue = {
            hybridMode = true,
        },
    },
}

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
            -- css
            html = html,
            cssls = cssls,
            tailwindcss = tailwindcss,

            -- javascript
            vtsls = vtsls,
            astro = astro,
            volar = volar,

            -- php
            intelephense = intelephense,

            -- go
            gopls = gopls,
            templ = templ,
        },
        setup = {
            -- css
            tailwindcss = tailwindcss_setup,

            -- javascript
            vtsls = vtsls_setup,
            astro = astro_setup,

            -- go
            gopls = gopls_setup,
        },
    },
    keys = {
        { "<leader>k", vim.diagnostic.open_float, desc = "hover diagnostics", mode = "n" },
    },
}
