vim.pack.add({
  {
    src = "https://github.com/akinsho/bufferline.nvim",
    version = vim.version.range("4"),
  },
})

require("bufferline").setup({
  options = {
    close_command = "bdelete! %d",
    right_mouse_command = "bdelete! %d",
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false,
    always_show_bufferline = false,
    mode = "buffers",
    numbers = "none",
    left_mouse_command = "buffer %d",
    middle_mouse_command = nil,
    modified_icon = "●",
    close_icon = "",
    left_trunc_marker = "",
    right_trunc_marker = "",
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    separator_style = "thin",
    enforce_regular_tabs = false,
    exclude_ft = {
      "dashboard",
    },
    indicator = {
      icon = "▎",
      style = "icon",
    },
    offsets = {
      {
        filetype = "neo-tree",
        text = "File Tree",
        highlight = "Directory",
        text_align = "left",
      },
    },
  },
})

local function close_terminals_or_others()
  local bufs = vim.api.nvim_list_bufs()
  local current = vim.api.nvim_get_current_buf()
  local terminals = {}
  local others = {}

  for _, buf in ipairs(bufs) do
    if vim.api.nvim_buf_is_loaded(buf) and buf ~= current then
      if vim.bo[buf].buftype == "terminal" then
        terminals[#terminals + 1] = buf
      elseif vim.bo[buf].buflisted then
        others[#others + 1] = buf
      end
    end
  end

  local targets = #terminals > 0 and terminals or others
  if #targets == 0 then
    vim.notify("No buffers to close", vim.log.levels.INFO)
    return
  end

  for _, buf in ipairs(targets) do
    vim.cmd("bdelete! " .. buf)
  end
end

_G.close_terminals_or_others = close_terminals_or_others


