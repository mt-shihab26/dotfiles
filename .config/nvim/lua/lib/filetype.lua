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

local glsl_patterns = {
    "^%s*#version%s",
    "^%s*precision%s+%a+%s+%a+%s*;",
    "^%s*uniform%s",
    "^%s*varying%s",
    "^%s*attribute%s",
    "^%s*layout%s*%(",
    "void%s+main%s*%(",
    "gl_%u%a+",
}

--- whether the first lines of a buffer look like a GLSL shader
---@param bufnr integer
---@return boolean
local function is_glsl(bufnr)
    for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, 100, false)) do
        for _, pattern in ipairs(glsl_patterns) do
            if line:match(pattern) then
                return true
            end
        end
    end
    return false
end


--- treat .fs/.vs files that look like GLSL shaders as "glsl" (.fs otherwise stays F#/Forth)
function M.glsl()
    vim.filetype.add {
        extension = {
            fs = function(path, bufnr)
                if is_glsl(bufnr) then
                    return "glsl"
                end
                return require("vim.filetype.detect").fs(path, bufnr)
            end,
            vs = function(_, bufnr)
                if is_glsl(bufnr) then
                    return "glsl"
                end
            end,
        },
    }
end

return M
