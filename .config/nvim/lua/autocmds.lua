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
    },
}

vim.treesitter.language.register("markdown", "mdx")
