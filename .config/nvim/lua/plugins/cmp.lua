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

local icons = {
    Array = " ",
    Boolean = "󰨙 ",
    Class = " ",
    Codeium = "󰘦 ",
    Color = " ",
    Control = " ",
    Collapsed = " ",
    Constant = "󰏿 ",
    Constructor = " ",
    Copilot = " ",
    Enum = " ",
    EnumMember = " ",
    Event = " ",
    Field = " ",
    File = " ",
    Folder = " ",
    Function = "󰊕 ",
    Interface = " ",
    Key = " ",
    Keyword = " ",
    Method = "󰊕 ",
    Module = " ",
    Namespace = "󰦮 ",
    Null = " ",
    Number = "󰎠 ",
    Object = " ",
    Operator = " ",
    Package = " ",
    Property = " ",
    Reference = " ",
    Snippet = " ",
    String = " ",
    Struct = "󰆼 ",
    TabNine = "󰏚 ",
    Text = " ",
    TypeParameter = " ",
    Unit = " ",
    Value = " ",
    Variable = "󰀫 ",
}

return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-calc",
        "hrsh7th/cmp-cmdline",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
    },
    config = function()
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
                ["<Tab>"] = cmp.mapping(tab_fallback(cmp, luasnip), { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(shift_tab_fallback(cmp, luasnip), { "i", "s" }),
            },
            sources = {
                { name = "nvim_lsp" },
                { name = "nvim_lsp_signature_help" },
                { name = "buffer" },
                { name = "path" },
                { name = "calc" },
                { name = "cmdline" },
                { name = "luasnip" },
            },
            formatting = {
                format = function(_, item)
                    if icons[item.kind] then
                        item.kind = icons[item.kind] .. item.kind
                    end

                    local widths = {
                        abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
                        menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
                    }

                    for key, width in pairs(widths) do
                        if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
                            item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
                        end
                    end

                    return item
                end,
            },
            experimental = {
                ghost_text = {
                    hl_group = "CmpGhostText",
                },
            },
        }

        local loader = require "luasnip.loaders.from_vscode"

        -- Load snippets
        loader.lazy_load() -- load friendly-snippets
        loader.lazy_load { paths = { vim.fn.stdpath "config" .. "/snippets" } } -- load ~/.config/nvim/snippets
    end,
}
