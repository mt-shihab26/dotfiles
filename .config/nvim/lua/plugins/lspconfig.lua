local lazy = require "lib.lazy"

-- loads right after startup; vim.lsp.enable then attaches the servers to the buffers already open
lazy.add({
    {
        src = "https://github.com/neovim/nvim-lspconfig",
        version = vim.version.range "2",
    },
    {
        src = "https://github.com/j-hui/fidget.nvim",
        version = vim.version.range "2",
    },
}, {
    defer = true,
    setup = function()
        local fidget = require "fidget"
        local lsp_file_operations = require "lsp-file-operations"
        local cmp_nvim_lsp = require "cmp_nvim_lsp"
        local buffer = require "lib.buffer"

        fidget.setup { notification = { window = { winblend = 0 } } }

        -- lsp-file-operations is set up with neo-tree (plugins/neo-tree.lua), its capabilities work without that
        local capabilities = vim.tbl_deep_extend(
            "force",
            vim.lsp.protocol.make_client_capabilities(),
            cmp_nvim_lsp.default_capabilities(),
            lsp_file_operations.default_capabilities()
        )

        -- every client start (including vim.lsp.enable) goes through vim.lsp.start
        local lsp_start = vim.lsp.start
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.lsp.start = function(config, opts)
            local bufnr = opts and opts.bufnr or 0
            if bufnr == 0 then
                bufnr = vim.api.nvim_get_current_buf()
            end
            if buffer.is_stopped(bufnr, "lsp") then
                return nil
            end
            return lsp_start(config, opts)
        end

        -- LSP sends malformed colors (float > 1.0 → >255 → 7-digit hex), disable until upstream fix.
        if vim.lsp.document_color then
            vim.lsp.document_color.enable(false)
        end
        -- Suppress handler for in-flight responses that arrive after disable.
        vim.lsp.handlers["textDocument/documentColor"] = function() end

        local servers = require "lists.servers"

        for _, server_name in ipairs(servers) do
            local server_settings = {}
            local ok, settings = pcall(require, "lsp." .. server_name)
            if ok then
                server_settings = settings
            end

            local config = vim.tbl_deep_extend("force", { capabilities = capabilities }, server_settings)

            vim.lsp.config(server_name, config)
            vim.lsp.enable(server_name)
        end
    end,
})
