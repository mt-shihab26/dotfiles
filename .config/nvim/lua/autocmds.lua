-- :wa writes all buffers without formatting them (see lib/toggle.lua)
vim.cmd [[cnoreabbrev <expr> wa (getcmdtype() == ':' && getcmdline() == 'wa') ? 'lua require("lib.toggle").write_all_no_format()' : 'wa']]

-- highlight yanked text briefly
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.hl.on_yank()
    end,
})

-- new C/C++ header files start with "#pragma once" (see lib/header.lua), this covers netrw's %
-- and :e; neo-tree creates the file on disk first, so it calls the same function from its file_added event
vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = { "*.h", "*.hpp" },
    callback = function(args)
        require("lib.header").add_pragma_once(vim.api.nvim_buf_get_name(args.buf))
    end,
})

-- binary files open in hex view, or in normal view when large (see lib/hex.lua), images never get
-- here since snacks reads them itself
vim.api.nvim_create_autocmd("BufReadPre", {
    callback = function(args)
        require("lib.hex").prepare(args.buf)
    end,
})
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function(args)
        require("lib.hex").attach(args.buf)
    end,
})

-- custom filetype detection
vim.filetype.add {
    extension = {
        -- .mdx: highlighted with the markdown parser (registered below), code fences, JSX blocks and
        -- frontmatter get their own languages through injections
        mdx = "mdx",
        -- *.gitconfig: config fragments pulled in by [include]
        gitconfig = "gitconfig",
        -- .glsl: one file holds every stage of a shader, each section opened by a "#type <stage>" line
        -- such as "#type vertex" or "#type fragment"
        glsl = "glsl",
        -- .slang: built-in as "shaderslang" since Neovim 0.11, highlighted by the slang treesitter parser
        -- .ejs: not detected by Neovim, highlighted by the embedded_template parser loaded as "ejs" (below)
        ejs = "ejs",
    },
}

vim.treesitter.language.register("markdown", "mdx")

-- .ejs: the embedded_template parser (also behind .erb) loaded a second time under the name "ejs", so
-- queries/ejs/injections.scm can inject javascript into the <% %> tags where the erb queries inject ruby.
-- Fails quietly until nvim-treesitter has installed the parser
local ejs_parser = vim.api.nvim_get_runtime_file("parser/embedded_template.so", false)[1]
if ejs_parser then
    pcall(vim.treesitter.language.add, "ejs", { path = ejs_parser, symbol_name = "embedded_template" })
end
