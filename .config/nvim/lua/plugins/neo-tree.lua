vim.pack.add({
  {
    src = 'https://github.com/nvim-neo-tree/neo-tree.nvim',
    version = vim.version.range('3')
  },
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
})

require("neo-tree").setup({
  filesystem = {
    use_libuv_file_watcher = true,
    hijack_netrw_behavior = "open_current",
    filtered_items = {
      visible = false,
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_hidden = false,
      never_show = { ".git" },
    },
    follow_current_file = {
      enabled = true,
      leave_dirs_open = true,
    },
  },
})
