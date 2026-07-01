vim.api.nvim_create_user_command("PackList", function()
  local plugins = vim.pack.get()
  local lines = {}
  for _, p in ipairs(plugins) do
    local status = p.active and "active" or "inactive"
    local rev = p.rev and p.rev:sub(1, 7) or "?"
    local tag = vim.fn.system(
      "git -C " .. vim.fn.shellescape(p.path) .. " describe --tags --exact-match HEAD 2>/dev/null"
    ):gsub("\n", "")
    local version = tag ~= "" and tag or rev
    lines[#lines + 1] = ("[%s] %s @ %s"):format(status, p.spec.name, version)
  end
  vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO)
end, { desc = "list installed plugins and their status" })

vim.api.nvim_create_user_command("PackCheck", function()
  vim.notify("Checking for updates...", vim.log.levels.INFO)
  local plugins = vim.pack.get(nil, { offline = false })
  local pending = {}
  for _, p in ipairs(plugins) do
    if p.rev_to and p.rev_to ~= p.rev then
      pending[#pending + 1] = ("%s: %s → %s"):format(
        p.spec.name,
        p.rev and p.rev:sub(1, 7) or "?",
        p.rev_to:sub(1, 7)
      )
    end
  end
  if #pending == 0 then
    vim.notify("All plugins are up to date", vim.log.levels.INFO)
  else
    vim.notify("Pending updates:\n" .. table.concat(pending, "\n"), vim.log.levels.WARN)
  end
end, { desc = "check for pending plugin updates (online)" })

vim.api.nvim_create_user_command("PackRemoveAll", function()
  local plugins = vim.pack.get()
  if #plugins == 0 then
    vim.notify("No plugins to remove", vim.log.levels.INFO)
    return
  end
  local names = vim.tbl_map(function(p) return p.spec.name end, plugins)
  local choice = vim.fn.confirm(("Remove all %d plugins?"):format(#names), "&Yes\n&No", 2)
  if choice ~= 1 then return end
  local removed = {}
  for _, name in ipairs(names) do
    vim.pack.del({ name }, { force = true })
    removed[#removed + 1] = "- " .. name
  end
  vim.notify("Removed plugins:\n" .. table.concat(removed, "\n"), vim.log.levels.INFO)
end, { desc = "remove all plugins from disk (including active)" })

