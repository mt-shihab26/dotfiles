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
        require("copilot").setup { suggestion = { enabled = false }, panel = { enabled = false } }

        require("copilot_cmp").setup()

        -- Define sources with their display labels and priorities in one place
        local sources_config = {
            nvim_lsp = { label = "lsp", priority = 1000 },
            nvim_lsp_signature_help = { label = "signature", priority = 900 },
            path = { label = "path", priority = 800 },
            copilot = { label = "Copilot", priority = 700 },
            luasnip = { label = "snippet", priority = 600 },
            buffer = { label = "buffer", priority = 500 },
            calc = { label = "calc", priority = 400 },
        }

        ---@type table
        local cmp = require "cmp"
        ---@type table
        local luasnip = require "luasnip"

        local has_words_before = function()
            if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
                return false
            end
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match "^%s*$" == nil
        end

        -- Custom sorting function using the centralized sources_config
        local sort_items = function(items, query, _, _)
            -- Calculate scores for each item based on multiple factors
            for _, item in ipairs(items) do
                local score = 0

                -- Priority based on source
                local source_name = item.source.name or ""
                local source_priority = sources_config[source_name] and sources_config[source_name].priority or 0
                score = score + source_priority

                -- Exact match bonus
                if item.exact_match then
                    score = score + 100
                end

                -- Word match bonus (if item starts with the query)
                if
                    query
                    and query ~= ""
                    and item.filter_text
                    and item.filter_text:lower():find(query:lower(), 1, true) == 1
                then
                    score = score + 80
                end

                -- Shorter completions are often better
                if item.completion_item and item.completion_item.label then
                    local label_length = #item.completion_item.label
                    if label_length < 20 then
                        score = score + (20 - label_length)
                    end
                end

                -- Save score on the item for sorting
                item.score = score
            end

            -- Sort based on calculated scores
            table.sort(items, function(a, b)
                return (a.score or 0) > (b.score or 0)
            end)

            return items
        end

        -- Build sources array from the centralized config
        local sources_array = {}
        for name, config in pairs(sources_config) do
            table.insert(sources_array, { name = name, priority = config.priority })
        end

        cmp.setup {
            preselect = cmp.PreselectMode.Item,
            sorting = {
                priority_weight = 2,
                comparators = {
                    sort_items,
                    cmp.config.compare.offset,
                    cmp.config.compare.exact,
                    cmp.config.compare.score,
                    cmp.config.compare.recently_used,
                    cmp.config.compare.locality,
                    cmp.config.compare.kind,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
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
            sources = sources_array,
            formatting = {
                fields = { "abbr", "kind", "menu" },
                format = function(entry, item)
                    -- Ensure source name is a string
                    local source_name = entry.source.name or ""
                    local source_label = sources_config[source_name] and sources_config[source_name].label
                        or source_name
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
