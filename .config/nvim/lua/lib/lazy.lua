-- lazy loading on top of vim.pack: the plugin is registered at startup (installed, locked, kept by :PackPrune and
-- :PackUpdate), but only put on the runtimepath, sourced and set up the first time it's needed
local M = {}

-- top-level lua module name -> load function of the plugin that provides it
local by_module = {}

-- requiring a module of a plugin that isn't loaded yet loads the plugin first
table.insert(package.loaders, 1, function(modname)
    local load = by_module[modname:match "^[^.]+"]
    if not load then
        return
    end
    load()
    -- the plugin's setup may already have required this module, hand that one out instead of running it twice
    local mod = package.loaded[modname]
    if mod ~= nil then
        return function()
            return mod
        end
    end
end)

---@class lib.lazy.Opts
---@field setup? fun()       configure the plugin, runs right after it loads
---@field modules? string[]  requiring one of these (or a submodule) loads the plugin
---@field commands? string[] running one of these commands loads the plugin, then runs the command
---@field defer? boolean     load right after startup, once the first screen is drawn

---@param specs (string|vim.pack.Spec)[]
---@param opts lib.lazy.Opts
---@return fun() load load the plugin now, does nothing once it's loaded
function M.add(specs, opts)
    local plugins = {}
    vim.pack.add(specs, {
        load = function(plugin)
            plugins[#plugins + 1] = plugin
        end,
    })

    local loaded = false
    local function load()
        if loaded then
            return
        end
        loaded = true
        for _, module in ipairs(opts.modules or {}) do
            by_module[module] = nil
        end
        for _, command in ipairs(opts.commands or {}) do
            pcall(vim.api.nvim_del_user_command, command)
        end
        for _, plugin in ipairs(plugins) do
            vim.cmd.packadd { vim.fn.escape(plugin.spec.name, " "), magic = { file = false } }
            -- :packadd only sources plugin/, the after/plugin/ scripts (e.g. cmp sources) need sourcing too
            for _, path in ipairs(vim.fn.glob(plugin.path .. "/after/plugin/**/*.{vim,lua}", false, true)) do
                vim.cmd.source { path, magic = { file = false } }
            end
        end
        if opts.setup then
            opts.setup()
        end
    end

    for _, module in ipairs(opts.modules or {}) do
        by_module[module] = load
    end

    for _, command in ipairs(opts.commands or {}) do
        vim.api.nvim_create_user_command(command, function(args)
            load()
            local range = args.range > 0 and ("%d,%d"):format(args.line1, args.line2) or ""
            vim.cmd(range .. command .. (args.bang and "!" or "") .. " " .. args.args)
        end, {
            nargs = "*",
            bang = true,
            range = true,
            complete = function(_, line)
                load()
                return vim.fn.getcompletion(line, "cmdline")
            end,
        })
    end

    if opts.defer then
        -- scheduled from VimEnter, so it runs after the startup files are opened and the screen is drawn
        vim.api.nvim_create_autocmd("VimEnter", {
            once = true,
            callback = function()
                vim.schedule(load)
            end,
        })
    end

    return load
end

return M
