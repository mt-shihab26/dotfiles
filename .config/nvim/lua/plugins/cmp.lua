vim.pack.add {
    "https://github.com/hrsh7th/nvim-cmp",
    "https://github.com/hrsh7th/cmp-nvim-lsp",
    "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help",
    "https://github.com/hrsh7th/cmp-buffer",
    "https://github.com/hrsh7th/cmp-path",
    "https://github.com/hrsh7th/cmp-calc",
    "https://github.com/L3MON4D3/LuaSnip",
    "https://github.com/saadparwaiz1/cmp_luasnip",
    "https://github.com/roobert/tailwindcss-colorizer-cmp.nvim",
    "https://github.com/zbirenbaum/copilot-cmp",
    "https://github.com/zbirenbaum/copilot.lua",
}

local cmp = require "cmp"

cmp.setup {
    preselect = cmp.PreselectMode.Item,
    sorting = (require "cmp.config.default")().sorting,
    completion = {
        completeopt = "menu,menuone,noinsert",
    },
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
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
            local source_name = entry.source.name or ""
            local source_label
            if source_name == "nvim_lsp" then
                local client = vim.lsp.get_client_by_id(entry.source.source.client.id)
                source_label = "lsp->" .. (client and client.name or "unknown")
            else
                local sources = {
                    nvim_lsp_signature_help = "signature",
                    buffer = "buffer",
                    path = "path",
                    calc = "calc",
                    luasnip = "snippet",
                    copilot = "copilot",
                }
                source_label = sources[source_name] or source_name
            end
            item.kind = string.format("[%s] %s", source_label, item.kind or "")
            return require("tailwindcss-colorizer-cmp").formatter(entry, item)
        end,
    },
}

require("luasnip.loaders.from_vscode").lazy_load {
    paths = { vim.fn.stdpath "config" .. "/snippets" },
}

require("copilot_cmp").setup {}

require("copilot").setup {
    suggestion = { enabled = false },
    panel = { enabled = false },
}

vim.cmd "Copilot disable"
