vim.pack.add({
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = "main",
  },
  { 
    src = "https://github.com/windwp/nvim-autopairs", 
    version = vim.version.range("0.11") 
  },
  {
      src = "https://github.com/windwp/nvim-ts-autotag"
      version = "main"
  }
  { src = "https://github.com/folke/ts-comments.nvim", version = vim.version.range("1") },
})

vim.schedule(function()
  local ts = require "nvim-treesitter"
  if ts.install then
    ts.install(require "lists.parsers")
  end
end)

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    pcall(vim.treesitter.start)
    if args.match ~= "yaml" then
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

vim.treesitter.language.register("markdown", "mdx")
vim.treesitter.language.register("markdown", "markdown.mdx")

require("nvim-autopairs").setup({})
require("nvim-ts-autotag").setup({})
require("ts-comments").setup({})

