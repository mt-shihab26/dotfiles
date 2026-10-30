-- on the runtimepath from the start: its queries highlight the files opened at startup
vim.pack.add {
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        version = "main",
    },
}

vim.schedule(function()
    local ok, treesitter = pcall(require, "nvim-treesitter")
    if not ok then
        return
    end

    if treesitter.install then
        local parsers = require "lists.parsers"
        treesitter.install(parsers)
    end
end)

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function(args)
        local buf = args.buf
        local ft = vim.bo[buf].filetype

        local lang = vim.treesitter.language.get_lang(ft)
        if not lang then
            return
        end

        local ok_add = pcall(vim.treesitter.language.add, lang)
        if not ok_add then
            return
        end

        pcall(vim.treesitter.start, buf, lang)
    end,
})

local lazy = require "lib.lazy"

-- loads right after startup
lazy.add({
    {
        src = "https://github.com/windwp/nvim-autopairs",
        version = vim.version.range "0.10",
    },
    {
        src = "https://github.com/windwp/nvim-ts-autotag",
        version = "main",
    },
    {
        src = "https://github.com/folke/ts-comments.nvim",
        version = vim.version.range "1",
    },
}, {
    defer = true,
    setup = function()
        require("nvim-autopairs").setup {}

        -- autotag renames the closing tag to match the opening one just edited (and the other way around), but a
        -- tag still being typed, like <Heading with no > yet, parses as the opening tag of the next element, whose
        -- closing tag (</div>) then got renamed; only rename tags that parse. Replaced before setup, which hands
        -- the function to the InsertLeave autocmds of the buffers it attaches to
        local autotag = require "nvim-ts-autotag.internal"
        local rename_tag = autotag.rename_tag
        autotag.rename_tag = function()
            local ok, parser = pcall(vim.treesitter.get_parser)
            if not ok or not parser then
                return
            end
            parser:parse(true)
            -- the tag name under the cursor, and the tag it's the name of
            local node = vim.treesitter.get_node { ignore_injections = false }
            if node and (node:has_error() or (node:parent() and node:parent():has_error())) then
                return
            end
            rename_tag()
        end
        require("nvim-ts-autotag").setup {}
        require("ts-comments").setup {}
    end,
})
