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
        local lspconfig = require "lspconfig"
        local mason = require "mason"
        local mason_lspconfig = require "mason-lspconfig"
        local cmp_nvim_lsp = require "cmp_nvim_lsp"
        local lsp_file_operations = require "lsp-file-operations"
        local which_key = require "which-key"
        local servers = require "configs.servers"

        mason.setup {}
        mason_lspconfig.setup { ensure_installed = vim.tbl_keys(servers), automatic_installation = true }
        lsp_file_operations.setup()

        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- Modify handler for textDocument/definition
        ---@diagnostic disable: duplicate-set-field
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

        local function restart_all_lsp()
            local active_clients = vim.lsp.get_active_clients()

            if #active_clients == 0 then
                vim.notify("No active LSP clients found", vim.log.levels.WARN)
                return
            end

            for _, client in ipairs(active_clients) do
                vim.lsp.stop_client(client.id)
                vim.notify(string.format("Stopped LSP client: %s", client.name), vim.log.levels.INFO)
            end

            vim.defer_fn(function()
                vim.cmd "edit"
                vim.notify("LSP servers restarted", vim.log.levels.INFO)
            end, 100)
        end

        local function stop_all_lsp()
            local active_clients = vim.lsp.get_active_clients()
            if #active_clients == 0 then
                vim.notify("No active LSP clients found", vim.log.levels.WARN)
                return
            end

            for _, client in ipairs(active_clients) do
                vim.lsp.stop_client(client.id)
                vim.notify(string.format("Stopped LSP client: %s", client.name), vim.log.levels.INFO)
            end
            vim.notify("All LSP servers stopped", vim.log.levels.INFO)
        end

        local function start_all_lsp()
            vim.cmd "edit"
            vim.notify("Starting LSP servers...", vim.log.levels.INFO)
        end

        local on_attach = function(_, bufnr)
            local opts = function(opts)
                return vim.tbl_extend("force", {
                    noremap = true,
                    silent = true,
                    buffer = bufnr,
                }, opts or {})
            end

            local restart_buffer_lsp = function()
                local clients = vim.lsp.get_active_clients { bufnr = bufnr }
                for _, client in ipairs(clients) do
                    vim.lsp.buf_request(bufnr, "workspace/executeCommand", {
                        command = "_typescript.restartServer",
                    })
                    vim.notify(string.format("Restarting LSP: %s", client.name))
                end
            end

            local stop_buffer_lsp = function()
                local clients = vim.lsp.get_active_clients { bufnr = bufnr }
                for _, client in ipairs(clients) do
                    vim.lsp.stop_client(client.id)
                    vim.notify(string.format("Stopped LSP client: %s", client.name), vim.log.levels.INFO)
                end
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

            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts { desc = "go to prev diagnostic" })
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts { desc = "go to next diagnostic" })

            which_key.add { { "<leader>L", group = "lsp servers" } }

            vim.keymap.set("n", "<leader>Ls", stop_buffer_lsp, opts { desc = "stop buffer lsp servers" })
            vim.keymap.set("n", "<leader>LS", stop_all_lsp, opts { desc = "stop all lsp servers" })
            vim.keymap.set("n", "<leader>Ll", start_all_lsp, opts { desc = "start all lsp servers" })
            vim.keymap.set("n", "<leader>Lr", restart_buffer_lsp, opts { desc = "restart buffer buffer servers" })
            vim.keymap.set("n", "<leader>LR", restart_all_lsp, opts { desc = "restart all lsp servers" })
        end

        for server_name, server_settings in pairs(servers) do
            lspconfig[server_name].setup(vim.tbl_deep_extend("force", {
                capabilities = capabilities,
                on_attach = on_attach,
            }, server_settings or {}))
        end
    end,
}
