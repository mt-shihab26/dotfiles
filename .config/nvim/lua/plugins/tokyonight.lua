vim.pack.add({
  {
    src = "https://github.com/folke/tokyonight.nvim",
    version = vim.version.range("4"),
  },
})

require("tokyonight").setup({})

vim.cmd.colorscheme("tokyonight-night")
