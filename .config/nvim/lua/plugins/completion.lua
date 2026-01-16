return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-calc",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "roobert/tailwindcss-colorizer-cmp.nvim",
        "zbirenbaum/copilot-cmp",
    },
    config = function()
        require("copilot_cmp").setup {}

        local cmp = require "cmp"
        local luasnip = require "luasnip"

        cmp.setup {
            preselect = cmp.PreselectMode.Item,
            sorting = (require "cmp.config.default"()).sorting,
            completion = {
                completeopt = "menu,menuone,noinsert",
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            window = {
                ---@diagnostic disable-next-line: undefined-field
                completion = cmp.config.window.bordered(),
                ---@diagnostic disable-next-line: undefined-field
                documentation = cmp.config.window.bordered(),
            },
            mapping = {
                ["<M-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
                ["<M-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
                ["<M-y>"] = cmp.mapping(
                    cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = true,
                    },
                    { "i", "c" }
                ),
            },
            sources = {
                { name = "nvim_lsp" },
                { name = "nvim_lsp_signature_help" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "path" },
                { name = "calc" },
                { name = "copilot" },
            },
            formatting = {
                fields = { "abbr", "kind", "menu" },
                format = function(entry, item)
                    local sources = {
                        nvim_lsp = "lsp",
                        nvim_lsp_signature_help = "signature",
                        buffer = "buffer",
                        path = "path",
                        calc = "calc",
                        luasnip = "snippet",
                        copilot = "copilot",
                    }
                    local source_name = entry.source.name or ""
                    local source_label = sources[source_name] or source_name
                    local kind_text = item.kind or ""
                    item.kind = string.format("[%s] %s", source_label, kind_text)
                    return require("tailwindcss-colorizer-cmp").formatter(entry, item)
                end,
            },
        }

        require("luasnip.loaders.from_vscode").lazy_load {
            paths = { vim.fn.stdpath "config" .. "/snippets" },
        }
    end,
}
