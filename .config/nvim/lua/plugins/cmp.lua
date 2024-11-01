local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

local tab_fallback = function(cmp, luasnip)
    return function(fallback)
        if cmp.visible() then
            cmp.select_next_item()
        elseif luasnip.locally_jumpable(1) then
            luasnip.jump(1)
        elseif has_words_before() then
            cmp.complete()
        else
            fallback()
        end
    end
end

local shift_tab_fallback = function(cmp, luasnip)
    return function(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
        elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end
end

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
        "rafamadriz/friendly-snippets",
    },
    config = function()
        local sources = {
            nvim_lsp = "[lsp]",
            nvim_lsp_signature_help = "[signature]",
            buffer = "[buffer]",
            path = "[path]",
            calc = "[calc]",
            luasnip = "[snippet]",
        }

        ---@type table
        local cmp = require "cmp"
        ---@type table
        local luasnip = require "luasnip"
        ---@type table

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
                ["<Tab>"] = cmp.mapping(tab_fallback(cmp, luasnip), { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(shift_tab_fallback(cmp, luasnip), { "i", "s" }),
            },
            sources = {
                { name = "nvim_lsp" },
                { name = "nvim_lsp_signature_help" },
                { name = "buffer" },
                { name = "path" },
                { name = "calc" },
                { name = "luasnip" },
            },
            formatting = {
                fields = { "abbr", "kind", "menu" },
                format = function(entry, vim_item)
                    vim_item.menu = sources[entry.source.name] or entry.source.name
                    return vim_item
                end,
            },
        }

        local loader = require "luasnip.loaders.from_vscode"

        -- Load snippets
        loader.lazy_load() -- load friendly-snippets
        loader.lazy_load { paths = { vim.fn.stdpath "config" .. "/snippets" } } -- load ~/.config/nvim/snippets
    end,
}
