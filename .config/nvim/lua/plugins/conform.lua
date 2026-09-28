vim.pack.add {
    {
        src = "https://github.com/stevearc/conform.nvim",
    },
}

local conform = require "conform"
local formatters_by_ft = require "lists.formatters"

--- Walk up from the buffer's directory to find a project-local vite-plus binary.
local function find_local_vp(dirname)
    for dir in vim.fs.parents(dirname .. "/_") do
        local bin = dir .. "/node_modules/.bin/vp"
        if vim.uv.fs_stat(bin) then
            return dir, bin
        end
    end
end

conform.setup {
    formatters_by_ft = formatters_by_ft,
    formatters = {
        -- vite-plus (oxfmt); only used when the project has it installed locally, otherwise prettier runs
        vp = {
            command = function(_, ctx)
                local _, bin = find_local_vp(ctx.dirname)
                return bin or "vp"
            end,
            args = { "fmt", "--stdin-filepath", "$FILENAME" },
            stdin = true,
            cwd = function(_, ctx)
                return (find_local_vp(ctx.dirname))
            end,
            condition = function(_, ctx)
                return find_local_vp(ctx.dirname) ~= nil
            end,
        },
        ["google-java-format"] = {
            -- AOSP style uses 4-space indentation instead of Google's default 2-space
            prepend_args = { "--aosp" },
        },
    },
    format_on_save = function(bufnr)
        if vim.g.disable_autoformat then
            return
        end
        return {
            timeout_ms = 5000,
            lsp_format = "fallback",
        }
    end,
}
