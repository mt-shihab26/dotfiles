local backup_theme = require "utils.backup_theme"
local omarchy_theme = require "utils.omarchy_theme"

local last_mtime = nil

local function apply()
    local theme = omarchy_theme.parse()
    if not theme then
        backup_theme.apply()
        return
    end
    vim.pack.add(theme.pack_specs, { load = true })
    for mod, opts in pairs(theme.opts_by_module) do
        local ok, m = pcall(require, mod)
        if ok and m.setup then
            m.setup(opts)
        end
    end
    if not pcall(vim.cmd.colorscheme, theme.colorscheme) then
        backup_theme.apply()
    end
end

backup_theme.setup()

apply()

do
    local stat = vim.uv.fs_stat(omarchy_theme.THEME_FILE)
    last_mtime = stat and stat.mtime.sec
end

-- Pick up theme changes made via `omarchy theme set` without restarting Neovim.
vim.api.nvim_create_autocmd({ "FocusGained", "VimResume" }, {
    group = vim.api.nvim_create_augroup("OmarchyThemeSync", { clear = true }),
    callback = function()
        local stat = vim.uv.fs_stat(omarchy_theme.THEME_FILE)
        local mtime = stat and stat.mtime.sec
        if mtime and mtime ~= last_mtime then
            last_mtime = mtime
            apply()
        end
    end,
})

vim.api.nvim_create_user_command("OmarchyThemeSync", apply, {
    desc = "Re-apply the current Omarchy theme's Neovim colorscheme",
})
