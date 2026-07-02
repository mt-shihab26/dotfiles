-- netrw
vim.g.netrw_banner = 0

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- line display
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.list = true
vim.opt.listchars = { space = "·", trail = "·", tab = "→ ", eol = "↲", nbsp = "␣" }
vim.opt.signcolumn = "yes"
vim.opt.cmdheight = 0

-- splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"

-- files & undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.confirm = true
vim.opt.isfname:append "@-@"

-- spell
vim.opt.spell = true
vim.opt.spelllang = "en_us"

-- ui & input
vim.opt.laststatus = 3
vim.opt.termguicolors = true
vim.opt.mouse = "a"

-- clipboard (deferred to avoid startup latency)
vim.schedule(function()
    vim.opt.clipboard = "unnamedplus"
end)

-- LSP sends malformed colors (float > 1.0 → >255 → 7-digit hex), disable until upstream fix.
if vim.lsp.document_color then
    vim.lsp.document_color.enable(false)
end
-- Suppress handler for in-flight responses that arrive after disable.
vim.lsp.handlers["textDocument/documentColor"] = function() end

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Treat .mdx files as the "mdx" filetype.
vim.filetype.add {
    extension = {
        mdx = "mdx",
    },
}
