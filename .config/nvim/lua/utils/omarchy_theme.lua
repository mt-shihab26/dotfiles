local M = {}

M.THEME_FILE = vim.fn.expand "~/.local/state/omarchy/current/theme/neovim.lua"

local function plugin_module_name(entry)
    if entry.name then
        return entry.name
    end
    return (entry[1]:match "([^/]+)$" or entry[1]):gsub("%.nvim$", "")
end

-- Omarchy always writes this file in the same LazyVim-spec shape:
-- one or more plugin specs, plus a `LazyVim/LazyVim` spec carrying
-- `opts.colorscheme`. We don't use lazy.nvim, so translate it by hand.
function M.parse()
    local ok, spec = pcall(dofile, M.THEME_FILE)
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
            -- Name dependencies the same way a theme names its main plugin
            -- (e.g. "bjarneo/aether.nvim" -> "aether"), so a plugin required
            -- as a dependency by one theme and used directly by another
            -- resolves to the same on-disk directory instead of cloning twice.
            for _, dep in ipairs(entry.dependencies or {}) do
                table.insert(pack_specs, {
                    src = "https://github.com/" .. dep,
                    name = plugin_module_name { dep },
                })
            end
        end
    end

    if not colorscheme or #pack_specs == 0 then
        return nil
    end

    return { colorscheme = colorscheme, pack_specs = pack_specs, opts_by_module = opts_by_module }
end

return M
