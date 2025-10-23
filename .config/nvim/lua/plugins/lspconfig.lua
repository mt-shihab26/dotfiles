local lsp_start = function()
    vim.cmd "LspStart"
end

local lsp_stop = function()
    vim.cmd "LspStop"
end

local lsp_restart = function()
    vim.cmd "LspRestart"
end

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
            html = {},
            marksman = {},
            jsonls = {},
            yamlls = {},
            cssls = {},
            css_variables = {},
            tailwindcss = {},
            bashls = {},
            lua_ls = {},
            vtsls = require "settings.vtsls",
            astro = {},
            intelephense = {},
            pyright = {},
            gopls = {},
            templ = {},
            clangd = {},
        }

        local mason = require "mason"
        local mason_lspconfig = require "mason-lspconfig"
        local cmp_nvim_lsp = require "cmp_nvim_lsp"
        local lsp_file_operations = require "lsp-file-operations"

        mason.setup {}
        mason_lspconfig.setup { ensure_installed = vim.tbl_keys(servers), automatic_installation = true }
        lsp_file_operations.setup {}

        local capabilities = vim.tbl_deep_extend(
            "force",
            vim.lsp.protocol.make_client_capabilities(),
            cmp_nvim_lsp.default_capabilities(),
            lsp_file_operations.default_capabilities()
        )

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

                map("n", "<leader>ls", lsp_start, opts "start LSP server")
                map("n", "<leader>lS", lsp_stop, opts "stop LSP server")
                map("n", "<leader>lr", lsp_restart, opts "restart LSP server")
            end,
        })

        for server_name, server_settings in pairs(servers) do
            local config = vim.tbl_deep_extend("force", { capabilities = capabilities }, server_settings or {})
            vim.lsp.config(server_name, config)
            vim.lsp.enable(server_name)
        end
    end,
}
