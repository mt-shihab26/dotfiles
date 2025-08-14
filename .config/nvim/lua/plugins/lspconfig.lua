return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "antosha417/nvim-lsp-file-operations",
        "folke/which-key.nvim",
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local servers = {
            -- JavaScript
            vtsls = require "settings.vtsls", -- TypeScript
            astro = {}, -- Astro
            -- Ruby
            ruby_lsp = {},
            -- PHP
            intelephense = require "settings.intelephense", -- PHP
            -- Python
            pyright = require "settings.pyright", -- Python
            -- Java
            java_language_server = {}, -- Java
            kotlin_lsp = {}, -- Kotlin
            gradle_ls = {}, -- Gradle
            -- Go
            gopls = require "settings.gopls", -- Go
            templ = {}, -- Go Templ
            -- Rust
            rust_analyzer = {}, -- Rust
            -- C/C++
            clangd = {}, -- C/C++
            autotools_ls = {}, -- Makefile
            -- Others
            lua_ls = require "settings.lua_ls", -- Lua
            html = {}, -- HTML
            marksman = {}, -- Markdown
            cssls = {}, -- CSS
            css_variables = {}, -- CSS
            tailwindcss = require "settings.tailwindcss", -- TailwindCSS
            jsonls = {}, -- Json
            yamlls = {}, -- YAML
            bashls = {}, -- Bash
            -- sqls = {}, -- SQL
            -- dockerls = {}, -- Docker
            -- docker_compose_language_service = {}, -- Docker
            -- volar = require "settings.volar", -- Vue
            -- htmx = {}, -- HTMX
            -- angularls = {}, -- Angular
            -- svelte = {}, -- Svelte
            -- elixirls = {}, -- Elixir
            -- zls = {}, -- Zig
        }

        local lspconfig = require "lspconfig"
        local mason = require "mason"
        local mason_lspconfig = require "mason-lspconfig"
        local cmp_nvim_lsp = require "cmp_nvim_lsp"
        local lsp_file_operations = require "lsp-file-operations"
        local lsp_func = require "utils.lsp-func"

        mason.setup {}
        mason_lspconfig.setup {
            ensure_installed = vim.tbl_keys(servers),
            automatic_installation = true,
            automatic_enable = false,
        }
        lsp_file_operations.setup()

        local capabilities = cmp_nvim_lsp.default_capabilities()

        vim.lsp.handlers["textDocument/definition"] = function(_, result, _, _)
            if not result or vim.tbl_isempty(result) then
                vim.notify("No definition found", vim.log.levels.WARN)
                return
            end

            if vim.tbl_islist(result) and #result > 0 then
                vim.lsp.util.jump_to_location(result[1], "utf-8")
            else
                vim.lsp.util.jump_to_location(result, "utf-8")
            end
        end

        lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
            capabilities = vim.tbl_deep_extend(
                "force",
                vim.lsp.protocol.make_client_capabilities(),
                lsp_file_operations.default_capabilities()
            ),
        })

        local on_attach = function()
            local opts = function(opts)
                return vim.tbl_extend("force", { noremap = true, silent = true }, opts or {})
            end

            local map = vim.keymap.set
            local buf = vim.lsp.buf
            local diagnostic = vim.diagnostic

            map("n", "gd", buf.definition, opts { desc = "go to definition (lspconfig)" })
            map("n", "gD", buf.declaration, opts { desc = "go to declaration (lspconfig)" })
            map("n", "gi", buf.implementation, opts { desc = "go to implementation (lspconfig)" })
            map("n", "gr", buf.references, opts { desc = "go to references (lspconfig)" })

            map("n", "K", buf.hover, opts { desc = "show hover documentation (lspconfig)" })
            map("n", "<C-k>", diagnostic.open_float, opts { desc = "show hover diagnostics (lspconfig)" })

            map("n", "<leader>h", buf.signature_help, opts { desc = "signature help (lspconfig)" })
            map("n", "<leader>a", buf.code_action, opts { desc = "code actions (lspconfig)" })
            map("n", "<leader>r", buf.rename, opts { desc = "rename symbol (lspconfig)" })

            map("n", "[d", diagnostic.goto_prev, opts { desc = "go to prev diagnostic (lspconfig)" })
            map("n", "]d", diagnostic.goto_next, opts { desc = "go to next diagnostic (lspconfig)" })

            map("n", "<leader>ls", lsp_func.lsp_start, opts { desc = "start LSP server" })
            map("n", "<leader>lS", lsp_func.lsp_stop, opts { desc = "stop LSP server" })
            map("n", "<leader>lr", lsp_func.lsp_restart, opts { desc = "restart LSP server" })
        end

        for server_name, server_settings in pairs(servers) do
            lspconfig[server_name].setup(
                vim.tbl_deep_extend(
                    "force",
                    { capabilities = capabilities, on_attach = on_attach },
                    server_settings or {}
                )
            )
        end
    end,
}
