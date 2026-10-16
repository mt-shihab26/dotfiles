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
        require("nvim-ts-autotag").setup {}
        require("ts-comments").setup {}
    end,
})
