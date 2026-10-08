local M = {}

--- treat .mdx files as the "mdx" filetype
function M.mdx()
    vim.filetype.add {
        extension = {
            mdx = "mdx",
        },
    }
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
