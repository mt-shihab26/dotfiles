vim.pack.add {
    {
        src = "https://github.com/stevearc/conform.nvim",
    },
}

local conform = require "conform"
local formatters_by_ft = require "lists.formatters"

conform.setup {
    formatters_by_ft = formatters_by_ft,
    format_on_save = function(bufnr)
        if vim.g.disable_autoformat then
            return
        end
        return {
            timeout_ms = 5000,
            lsp_format = "fallback",
        }
    end,
}
