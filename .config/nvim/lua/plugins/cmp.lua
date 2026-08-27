vim.pack.add {
    {
        src = "https://github.com/hrsh7th/nvim-cmp",
    },
    {
        src = "https://github.com/hrsh7th/cmp-nvim-lsp",
    },
    {
        src = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help",
    },
    {
        src = "https://github.com/hrsh7th/cmp-buffer",
    },
    {
        src = "https://github.com/hrsh7th/cmp-path",
    },
    {
        src = "https://github.com/hrsh7th/cmp-calc",
    },
    {
        src = "https://github.com/L3MON4D3/LuaSnip",
    },
    {
        src = "https://github.com/saadparwaiz1/cmp_luasnip",
    },
    {
        src = "https://github.com/roobert/tailwindcss-colorizer-cmp.nvim",
    },
}

local cmp = require "cmp"
local cmp_default = require "cmp.config.default"
local luasnip = require "luasnip"
local luasnip_vscode_loader = require "luasnip.loaders.from_vscode"
local tailwindcss_cmp = require "tailwindcss-colorizer-cmp"

cmp.setup {
    preselect = cmp.PreselectMode.Item,
    sorting = cmp_default().sorting,
    completion = {
        completeopt = "menu,menuone,noinsert",
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
        { name = "calc" },
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
                }
                source_label = sources[source_name] or source_name
            end
            item.kind = string.format("[%s] %s", source_label, item.kind or "")
            return tailwindcss_cmp.formatter(entry, item)
        end,
    },
    mapping = {
        ["<M-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ["<M-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        ["<M-y>"] = cmp.mapping(cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true }, { "i", "c" }),
    },
}


luasnip_vscode_loader.lazy_load {
    paths = { vim.fn.stdpath "config" .. "/snippets" },
}
