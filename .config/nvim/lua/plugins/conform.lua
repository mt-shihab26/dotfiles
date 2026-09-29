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

-- Echo the formatter that ran, with its resolved arguments, after each format
vim.api.nvim_create_autocmd("User", {
    pattern = "ConformFormatPost",
    callback = function(event)
        local bufnr = event.buf
        local name = event.data.formatter.name
        local runner = require "conform.runner"
        local config = conform.get_formatter_config(name, bufnr)
        if not config then
            return
        end
        local ctx = runner.build_context(bufnr, config)
        local cmd = runner.build_cmd(name, ctx, config)
        if type(cmd) == "table" then
            cmd = table.concat(
                vim.tbl_filter(function(arg)
                    return arg ~= ctx.filename
                end, cmd),
                " "
            )
        else
            cmd = cmd:gsub("%s*" .. vim.pesc(ctx.filename), "")
        end
        cmd = cmd:gsub(vim.pesc(vim.env.HOME), "~")
        local highlight = event.data.err and "ErrorMsg" or "Comment"
        vim.schedule(function()
            vim.api.nvim_echo({ { "[" .. name .. "] " .. cmd, highlight } }, false, {})
        end)
    end,
})
