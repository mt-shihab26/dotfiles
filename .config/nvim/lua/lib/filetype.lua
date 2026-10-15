local M = {}

--- treat .mdx files as the "mdx" filetype, highlighted with the markdown parser
--- (code fences, JSX blocks and frontmatter get their own languages through injections)
function M.mdx()
    vim.filetype.add {
        extension = {
            mdx = "mdx",
        },
    }
    vim.treesitter.language.register("markdown", "mdx")
end

--- treat *.gitconfig files (like config fragments pulled in by [include]) as "gitconfig"
function M.gitconfig()
    vim.filetype.add {
        extension = {
            gitconfig = "gitconfig",
        },
    }
end

--- treat .glsl files as "glsl": one file holds every stage of a shader, each
--- section opened by a "#type <stage>" line such as "#type vertex" or "#type fragment"
function M.glsl()
    vim.filetype.add {
        extension = {
            glsl = "glsl",
        },
    }
end

return M
