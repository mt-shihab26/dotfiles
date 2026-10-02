local M = {}

-- run git in `path` and return its trimmed output, or nil when it fails
local function git(path, args)
    local res = vim.system(vim.list_extend({ "git" }, args), { cwd = path, text = true }):wait()
    return res.code == 0 and vim.trim(res.stdout) or nil
end

-- the commit vim.pack.update() would move `p` to, resolved from the fetched refs the
-- same way vim.pack does: default branch, branch/tag/commit, or highest matching semver tag
local function update_target(p)
    local version = p.spec.version
    local ref
    if version == nil then
        ref = "origin/HEAD"
    elseif type(version) == "string" then
        local is_branch = git(p.path, { "rev-parse", "--verify", "--quiet", "origin/" .. version }) ~= nil
        ref = is_branch and "origin/" .. version or version
    else
        local best
        for _, tag in ipairs(vim.split(git(p.path, { "tag", "--list" }) or "", "\n", { trimempty = true })) do
            local ver = vim.version.parse(tag, { strict = true })
            if ver and version:has(ver) and (not best or ver > best.ver) then
                best = { tag = tag, ver = ver }
            end
        end
        ref = best and best.tag
    end
    return ref and git(p.path, { "rev-list", "-1", ref })
end

-- notify which of the fetched plugins have a newer target than their installed revision
local function report_pending(plugins, failed)
    local pending, errors = {}, {}
    for _, p in ipairs(plugins) do
        local target = not failed[p.spec.name] and update_target(p)
        if not target then
            errors[#errors + 1] = p.spec.name
        elseif target ~= p.rev then
            pending[#pending + 1] = ("%s: %s → %s"):format(p.spec.name, (p.rev or "?"):sub(1, 7), target:sub(1, 7))
        end
    end
    local lines = {}
    if #pending == 0 then
        lines[#lines + 1] = "All plugins are up to date"
    else
        lines[#lines + 1] = "Pending updates (apply with :PackUpdate):"
        vim.list_extend(lines, pending)
    end
    if #errors > 0 then
        lines[#lines + 1] = "Could not check: " .. table.concat(errors, ", ")
    end
    local level = (#pending > 0 or #errors > 0) and vim.log.levels.WARN or vim.log.levels.INFO
    vim.notify(table.concat(lines, "\n"), level)
end

function M.list(opts)
    local names = opts.args:match "%S" and vim.split(opts.args, "%s+", { trimempty = true }) or nil
    local plugins = vim.pack.get(names)
    local lines = {}
    for _, p in ipairs(plugins) do
        local status = p.active and "active" or "inactive"
        local rev = p.rev and p.rev:sub(1, 7) or "?"
        local tag = vim.fn
            .system("git -C " .. vim.fn.shellescape(p.path) .. " describe --tags --exact-match HEAD 2>/dev/null")
            :gsub("\n", "")
        local version = tag ~= "" and tag or rev
        lines[#lines + 1] = ("[%s] %s @ %s"):format(status, p.spec.name, version)
    end
    vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO)
end

function M.check(opts)
    local names = opts.args:match "%S" and vim.split(opts.args, "%s+", { trimempty = true }) or nil
    local plugins = vim.pack.get(names, { info = false })
    if #plugins == 0 then
        vim.notify("No plugins to check", vim.log.levels.INFO)
        return
    end
    vim.notify("Checking for updates...", vim.log.levels.INFO)

    -- fetch every plugin in parallel; this only updates origin refs, checkouts stay as they are
    local remaining = #plugins
    local failed = {}
    for _, p in ipairs(plugins) do
        vim.system({ "git", "fetch", "--quiet", "--tags", "--force", "origin" }, { cwd = p.path }, function(res)
            if res.code ~= 0 then
                failed[p.spec.name] = true
            end
            remaining = remaining - 1
            if remaining == 0 then
                vim.schedule(function()
                    report_pending(plugins, failed)
                end)
            end
        end)
    end
end

function M.update(opts)
    if opts.args:match "%S" then
        local plugins = vim.split(opts.args, "%s+", { trimempty = true })
        vim.pack.update(plugins)
    else
        vim.pack.update()
    end
end

function M.prune(opts)
    local names = opts.args:match "%S" and vim.split(opts.args, "%s+", { trimempty = true }) or nil
    local plugins = vim.pack.get(names)
    local inactive = {}
    for _, p in ipairs(plugins) do
        if not p.active then
            inactive[#inactive + 1] = p.spec.name
        end
    end
    if #inactive == 0 then
        vim.notify("No inactive plugins to remove", vim.log.levels.INFO)
        return
    end
    vim.pack.del(inactive)
end

function M.purge(opts)
    local names
    if opts.args:match "%S" then
        names = vim.split(opts.args, "%s+", { trimempty = true })
    else
        local plugins = vim.pack.get()
        if #plugins == 0 then
            vim.notify("No plugins to remove", vim.log.levels.INFO)
            return
        end
        names = vim.tbl_map(function(p)
            return p.spec.name
        end, plugins)
    end
    local choice = vim.fn.confirm(("Remove %d plugins?"):format(#names), "&Yes\n&No", 2)
    if choice ~= 1 then
        return
    end
    local removed = {}
    for _, name in ipairs(names) do
        vim.pack.del({ name }, { force = true })
        removed[#removed + 1] = "- " .. name
    end
    vim.notify("Removed plugins:\n" .. table.concat(removed, "\n"), vim.log.levels.INFO)
end

return M
