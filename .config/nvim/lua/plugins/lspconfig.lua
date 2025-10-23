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
            -- Markup
            html = {}, -- HTML
            marksman = {}, -- Markdown
            jsonls = {}, -- Json
            yamlls = {}, -- YAML
            -- dockerls = {}, -- Docker
            -- docker_compose_language_service = {}, -- Docker

            -- Sheet
            cssls = {}, -- CSS
            css_variables = {}, -- CSS
            tailwindcss = {}, -- TailwindCSS
            -- sqls = {}, -- SQL

            -- Shell
            bashls = {}, -- Bash

            -- Lua
            lua_ls = {}, -- Lua

            -- JavaScript
            vtsls = require "settings.vtsls", -- TypeScript
            -- vue_ls = {}, -- Vue
            astro = {}, -- Astro
            -- htmx = {}, -- HTMX
            -- angularls = {}, -- Angular
            -- svelte = {}, -- Svelte

            -- Ruby
            -- ruby_lsp = {},

            -- PHP
            intelephense = {}, -- PHP

            -- Python
            -- pyright = require "settings.pyright", -- Python

            -- Java
            -- java_language_server = {}, -- Java
            -- kotlin_lsp = {}, -- Kotlin
            -- gradle_ls = {}, -- Gradle

            -- Elixir
            -- elixirls = {}, -- Elixir

            -- Go
            gopls = {}, -- Go
            -- templ = {}, -- Go Templ

            -- Rust
            -- rust_analyzer = {}, -- Rust

            -- Zig
            -- zls = {}, -- Zig

            -- C/C++
            -- clangd = {}, -- C/C++
            -- autotools_ls = {}, -- Makefile
        }

        local mason = require "mason"
        local mason_lspconfig = require "mason-lspconfig"
        local cmp_nvim_lsp = require "cmp_nvim_lsp"
        local lsp_file_operations = require "lsp-file-operations"
        local lsp_func = require "utils.lsp-func"

        mason.setup {}
        mason_lspconfig.setup { ensure_installed = vim.tbl_keys(servers), automatic_installation = true }
        lsp_file_operations.setup {}

        -- Capabilities configuration
        local capabilities = vim.tbl_deep_extend(
            "force",
            vim.lsp.protocol.make_client_capabilities(),
            cmp_nvim_lsp.default_capabilities(),
            lsp_file_operations.default_capabilities()
        )

        -- Custom handler for textDocument/definition
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

        -- Setup keymaps on LspAttach
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local opts = function(desc)
                    return { buffer = args.buf, noremap = true, silent = true, desc = desc }
                end

                local map = vim.keymap.set
                local buf = vim.lsp.buf
                local diagnostic = vim.diagnostic

                map("n", "gd", buf.definition, opts "go to definition (lspconfig)")
                map("n", "gD", buf.declaration, opts "go to declaration (lspconfig)")
                map("n", "gi", buf.implementation, opts "go to implementation (lspconfig)")
                map("n", "gr", buf.references, opts "go to references (lspconfig)")

                map("n", "K", buf.hover, opts "show hover documentation (lspconfig)")
                map("n", "<C-k>", diagnostic.open_float, opts "show hover diagnostics (lspconfig)")

                map("n", "<leader>h", buf.signature_help, opts "signature help (lspconfig)")
                map("n", "<leader>a", buf.code_action, opts "code actions (lspconfig)")
                map("n", "<leader>r", buf.rename, opts "rename symbol (lspconfig)")

                map("n", "[d", diagnostic.goto_prev, opts "go to prev diagnostic (lspconfig)")
                map("n", "]d", diagnostic.goto_next, opts "go to next diagnostic (lspconfig)")

                map("n", "<leader>ls", lsp_func.lsp_start, opts "start LSP server")
                map("n", "<leader>lS", lsp_func.lsp_stop, opts "stop LSP server")
                map("n", "<leader>lr", lsp_func.lsp_restart, opts "restart LSP server")
            end,
        })

        -- Configure servers using vim.lsp.config
        for server_name, server_settings in pairs(servers) do
            -- Merge with global capabilities
            local config = vim.tbl_deep_extend("force", { capabilities = capabilities }, server_settings or {})

            -- Use vim.lsp.config to customize the server configuration
            vim.lsp.config(server_name, config)

            -- Enable the server (it will auto-start for its filetypes)
            vim.lsp.enable(server_name)
        end
    end,
}
