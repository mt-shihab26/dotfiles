return function(opts)
  local names = opts.args:match("%S") and vim.split(opts.args, "%s+", { trimempty = true }) or nil
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
