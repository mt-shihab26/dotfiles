return function(opts)
  local names
  if opts.args:match("%S") then
    names = vim.split(opts.args, "%s+", { trimempty = true })
  else
    local plugins = vim.pack.get()
    if #plugins == 0 then
      vim.notify("No plugins to remove", vim.log.levels.INFO)
      return
    end
    names = vim.tbl_map(function(p) return p.spec.name end, plugins)
  end
  local choice = vim.fn.confirm(("Remove %d plugins?"):format(#names), "&Yes\n&No", 2)
  if choice ~= 1 then return end
  local removed = {}
  for _, name in ipairs(names) do
    vim.pack.del({ name }, { force = true })
    removed[#removed + 1] = "- " .. name
  end
  vim.notify("Removed plugins:\n" .. table.concat(removed, "\n"), vim.log.levels.INFO)
end
