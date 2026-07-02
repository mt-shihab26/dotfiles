vim.pack.add {
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        version = "main",
    },
    {
        src = "https://github.com/windwp/nvim-autopairs",
        version = vim.version.range "0.10",
    },
    {
        src = "https://github.com/windwp/nvim-ts-autotag",
    },
    {
        src = "https://github.com/folke/ts-comments.nvim",
        version = vim.version.range "1",
    },
}

vim.schedule(function()
    local ok, treesitter = pcall(require, "nvim-treesitter")
    if not ok then
        return
    end

    if treesitter.install then
        treesitter.install(require "lists.parsers")
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

require("nvim-autopairs").setup {}
require("nvim-ts-autotag").setup {}
require("ts-comments").setup {}
