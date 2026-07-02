vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

local conform = require "conform"

local format_on_save = {
  timeout_ms = 5000,
  lsp_format = "fallback",
}

conform.setup({
  formatters_by_ft = require "lists.formatters",
  format_on_save = function(bufnr)
    if vim.g.disable_autoformat then return end
    return format_on_save
  end,
})

vim.api.nvim_create_user_command("FormatToggle", function()
  if vim.g.disable_autoformat then
    vim.g.disable_autoformat = false
    print "format on save enabled"
  else
    vim.g.disable_autoformat = true
    print "format on save disabled"
  end
end, { desc = "toggle format on save" })
