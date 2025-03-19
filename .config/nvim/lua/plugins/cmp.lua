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
        "zbirenbaum/copilot.lua",
        "zbirenbaum/copilot-cmp",
    },
    config = function()
        require("copilot").setup {
            suggestion = { enabled = false },
            panel = { enabled = false },
        }

        require("copilot_cmp").setup()

        local sources = {
            copilot = "copilot",
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

        -- Define custom sorting function to prioritize LSP over Copilot
        local compare = require "cmp.config.compare"

        local source_priority = {
            nvim_lsp = 10,
            nvim_lsp_signature_help = 9,
            copilot = 8,
            luasnip = 7,
            buffer = 6,
            path = 5,
            calc = 4,
        }

        local source_compare = function(entry1, entry2)
            local source1 = entry1.source.name
            local source2 = entry2.source.name
            local priority1 = source_priority[source1] or 0
            local priority2 = source_priority[source2] or 0
            return priority1 > priority2
        end

        cmp.setup {
            preselect = cmp.PreselectMode.Item,
            sorting = {
                priority_weight = 2,
                comparators = {
                    source_compare, -- Our custom source prioritization
                    compare.offset,
                    compare.exact,
                    compare.score,
                    compare.recently_used,
                    compare.locality,
                    compare.kind,
                    compare.sort_text,
                    compare.length,
                    compare.order,
                },
            },
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
                    -- Check if completion menu is visible
                    if cmp.visible() then
                        cmp.select_next_item()
                    -- Check if snippet can be expanded or jumped to next position
                    elseif luasnip.expand_or_jumpable() then
                        vim.fn.feedkeys(
                            vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true),
                            ""
                        )
                    -- Check if there are words before cursor position
                    elseif
                        (function()
                            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                            return col ~= 0
                                and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s"
                                    == nil
                        end)()
                    then
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
                -- lsp
                { name = "nvim_lsp", priority = 10 },
                { name = "nvim_lsp_signature_help", priority = 9 },
                -- copilot
                { name = "copilot", priority = 8 },
                -- snippet
                { name = "luasnip", priority = 7 },
                -- other
                { name = "buffer", priority = 6 },
                { name = "path", priority = 5 },
                { name = "calc", priority = 4 },
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

        require("luasnip.loaders.from_vscode").lazy_load {
            paths = { vim.fn.stdpath "config" .. "/snippets" },
        }
    end,
}
