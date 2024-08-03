require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

vim.o.relativenumber = true
vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true, silent = true })

local nvimtree = require "nvchad.configs.nvimtree"

nvimtree.git.ignore = false

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        require("conform").format { bufnr = args.buf }
    end,
})
