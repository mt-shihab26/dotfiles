vim.pack.add({
  {
    src = "https://github.com/folke/tokyonight.nvim",
    version = vim.version.range("4"),
  },
  "https://github.com/NvChad/nvim-colorizer.lua",
})

require("colorizer").setup({
  user_default_options = {
    names = false,
    tailwind = true,
  },
})

require("tokyonight").setup({})

vim.cmd.colorscheme("tokyonight-night")
