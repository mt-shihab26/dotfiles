return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            -- TypeScript
            html = { "prettier" },
            svg = { "prettier" },
            css = { "prettier" },
            scss = { "prettier" },
            less = { "prettier" },
            javascript = { "prettier" },
            javascriptreact = { "prettier" },
            typescript = { "prettier" },
            typescriptreact = { "prettier" },
            astro = { "prettier" },
            vue = { "prettier" },
            markdown = { "prettier" },
            mdx = { "prettier" },
            yaml = { "prettier" },
            json = { "prettier" },
            jsonc = { "prettier" },

            -- PHP
            php = { "pint" },
            blade = { "prettier" },

            -- Elixir

            -- Zig

            -- Others
            go = { "goimports", "gofumpt" },
            templ = { "templ" },
            rust = { "rustfmt" },
            fish = { "fish_indent" },
            sh = { "shfmt" },
            lua = { "stylua" },
        },
        format_on_save = {
            timeout_ms = 5000,
            -- lsp_format = "fallback",
        },
    },
}
