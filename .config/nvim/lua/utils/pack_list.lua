return function(opts)
  local names = opts.args:match("%S") and vim.split(opts.args, "%s+", { trimempty = true }) or nil
  local plugins = vim.pack.get(names)
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
end
