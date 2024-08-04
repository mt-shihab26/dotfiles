local config = function()
    local conform = require "conform"
    conform.setup {
        format_on_save = {
            -- These options will be passed to conform.format()
            timeout_ms = 2000,
            lsp_format = "fallback",
        },
        formatters_by_ft = {
            lua = { "stylua" },
            blade = { "prettier" },
            php = { "pint" },
        },
    }
end

return {
    {
        "stevearc/conform.nvim",
        config = config,
    },
}
