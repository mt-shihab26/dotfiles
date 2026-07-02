return function(opts)
  local names = opts.args:match("%S") and vim.split(opts.args, "%s+", { trimempty = true }) or nil
  vim.notify("Checking for updates...", vim.log.levels.INFO)
  local plugins = vim.pack.get(names, { offline = false })
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
end
