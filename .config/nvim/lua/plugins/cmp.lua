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
    },
    config = function()
        local sources = {
            nvim_lsp = "lsp",
            nvim_lsp_signature_help = "signature",
            buffer = "buffer",
            path = "path",
            calc = "calc",
            luasnip = "snippet",
        }

        ---@type table
        local cmp = require "cmp"
        ---@type table
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
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = {
                ["<CR>"] = cmp.mapping.confirm { select = true },
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.locally_jumpable(1) then
                        luasnip.jump(1)
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
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
                    -- Ensure source name is a string
                    local source_name = entry.source.name or ""
                    local source_label = sources[source_name] or source_name

                    -- Ensure kind is a string
                    local kind_text = item.kind or ""

                    -- Build the kind string safely
                    item.kind = string.format("[%s] %s", source_label, kind_text)

                    -- Apply tailwindcss colorizer formatting
                    return require("tailwindcss-colorizer-cmp").formatter(entry, item)
                end,
            },
        }

        -- Load snippets
        require("luasnip.loaders.from_vscode").lazy_load {
            paths = { vim.fn.stdpath "config" .. "/snippets" },
        }
    end,
}
