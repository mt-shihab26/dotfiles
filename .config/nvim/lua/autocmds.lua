-- :wa writes all buffers without formatting them (see lib/toggle.lua)
vim.cmd [[cnoreabbrev <expr> wa (getcmdtype() == ':' && getcmdline() == 'wa') ? 'lua require("lib.toggle").write_all_no_format()' : 'wa']]

-- highlight yanked text briefly
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.hl.on_yank()
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
