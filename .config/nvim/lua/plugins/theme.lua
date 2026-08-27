local omarchy_theme = require "lib.omarchy_theme"

local last_mtime = nil

local function current_mtime()
    local stat = vim.uv.fs_stat(omarchy_theme.THEME_FILE)
    return stat and stat.mtime.sec
end

local function setup_fallback()
    vim.pack.add {
        {
            src = "https://github.com/folke/tokyonight.nvim",
            version = vim.version.range "4",
        },
    }
end

local function apply_fallback()
    pcall(vim.cmd.colorscheme, "tokyonight-night")
end

local function apply_theme()
    local theme = omarchy_theme.parse()
    if not theme then
        apply_fallback()
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
        apply_fallback()
    end
end

-- Install every Omarchy theme's colorscheme plugin ahead of time (without
-- loading it) so switching themes only has to activate an already-cloned
-- plugin instead of cloning one from GitHub.
local function preinstall_all_theme_plugins()
    local specs, seen = {}, {}
    for _, file in ipairs(omarchy_theme.spec_files()) do
        local theme = omarchy_theme.parse(file)
        if theme then
            for _, spec in ipairs(theme.pack_specs) do
                local key = spec.name or spec.src
                if not seen[key] then
                    seen[key] = true
                    table.insert(specs, spec)
                end
            end
        end
    end
    if #specs > 0 then
        vim.pack.add(specs, { load = false })
    end
end

setup_fallback()
apply_theme()

last_mtime = current_mtime()

vim.defer_fn(preinstall_all_theme_plugins, 0)

vim.api.nvim_create_autocmd({ "FocusGained", "VimResume" }, {
    group = vim.api.nvim_create_augroup("OmarchyThemeSync", { clear = true }),
    callback = function()
        local mtime = current_mtime()
        if mtime and mtime ~= last_mtime then
            last_mtime = mtime
            apply_theme()
        end
    end,
})

vim.api.nvim_create_user_command("OmarchyThemeSync", apply_theme,
    { desc = "Re-apply the current Omarchy theme's Neovim colorscheme", }
)
