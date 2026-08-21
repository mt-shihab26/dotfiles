local backup_theme = require "utils.backup_theme"

local M = {}

local THEME_FILE = vim.fn.expand "~/.local/state/omarchy/current/theme/neovim.lua"

local last_mtime = nil

local function plugin_module_name(entry)
    if entry.name then
        return entry.name
    end
    return (entry[1]:match "([^/]+)$" or entry[1]):gsub("%.nvim$", "")
end

-- Omarchy always writes this file in the same LazyVim-spec shape:
-- one or more plugin specs, plus a `LazyVim/LazyVim` spec carrying
-- `opts.colorscheme`. We don't use lazy.nvim, so translate it by hand.
local function parse_omarchy_theme()
    local ok, spec = pcall(dofile, THEME_FILE)
    if not ok or type(spec) ~= "table" then
        return nil
    end

    local colorscheme, pack_specs, opts_by_module = nil, {}, {}

    for _, entry in ipairs(spec) do
        if entry[1] == "LazyVim/LazyVim" then
            colorscheme = entry.opts and entry.opts.colorscheme
        elseif entry[1] then
            table.insert(pack_specs, {
                src = "https://github.com/" .. entry[1],
                name = entry.name,
                version = entry.branch,
            })
            if entry.opts then
                opts_by_module[plugin_module_name(entry)] = entry.opts
            end
            for _, dep in ipairs(entry.dependencies or {}) do
                table.insert(pack_specs, { src = "https://github.com/" .. dep })
            end
        end
    end

    if not colorscheme or #pack_specs == 0 then
        return nil
    end

    return { colorscheme = colorscheme, pack_specs = pack_specs, opts_by_module = opts_by_module }
end

function M.apply()
    local theme = parse_omarchy_theme()

    if not theme then
        backup_theme.apply()
        return
    end

    -- Force `load = true`: this runs during init.lua sourcing, when
    -- vim.pack.add() defaults to installing without adding the plugin to
    -- 'runtimepath', which breaks colorscheme files that `require()` a
    -- dependency (e.g. hackerman.nvim requiring aether.nvim).
    vim.pack.add(theme.pack_specs, { load = true })

    for mod, opts in pairs(theme.opts_by_module) do
        local ok, m = pcall(require, mod)
        if ok and m.setup then
            m.setup(opts)
        end
    end

    vim.o.background = "dark"
    if not pcall(vim.cmd.colorscheme, theme.colorscheme) then
        backup_theme.apply()
    end
end

backup_theme.setup()

M.apply()
do
    local stat = vim.uv.fs_stat(THEME_FILE)
    last_mtime = stat and stat.mtime.sec
end

-- Pick up theme changes made via `omarchy theme set` without restarting Neovim.
vim.api.nvim_create_autocmd({ "FocusGained", "VimResume" }, {
    group = vim.api.nvim_create_augroup("OmarchyThemeSync", { clear = true }),
    callback = function()
        local stat = vim.uv.fs_stat(THEME_FILE)
        local mtime = stat and stat.mtime.sec
        if mtime and mtime ~= last_mtime then
            last_mtime = mtime
            M.apply()
        end
    end,
})

vim.api.nvim_create_user_command("OmarchyThemeSync", M.apply, {
    desc = "Re-apply the current Omarchy theme's Neovim colorscheme",
})
