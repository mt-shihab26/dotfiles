vim.keymap.set("n", "<leader>o", "<cmd>update<cr><cmd>source<cr>")

vim.keymap.set("n", "<leader>w", "<cmd>write<cr>")

vim.keymap.set("", "<leader>e", "<cmd>Neotree action=focus<cr>", { desc = "focus file tree (neo-tree)" })
vim.keymap.set("", "<leader>p", "<cmd>Neotree action=close<cr>", { desc = "close file tree (neo-tree)" })

-- Telescope (fuzzy finder)

local telescope = require("telescope")
local builtin = require("telescope.builtin")
local lga = require("telescope").extensions.live_grep_args

vim.keymap.set("n", "<leader>f", function()
  builtin.find_files {
	prompt_title = "Find Files",
  }
end, { desc = "Find files (Telescope)" })

vim.keymap.set("n", "<leader>F", function()
  builtin.find_files {
	prompt_title = "Find All Files",
	no_ignore = true,
  }
end, { desc = "Find all files (Telescope)" })

vim.keymap.set("n", "<leader>g", function()
  lga.live_grep_args {
	prompt_title = "Grep Files",
	vimgrep_arguments = {
	  "rg",
	  "--hidden",
	  "-L",
	  "--color=never",
	  "--sort=path",
	  "--no-heading",
	  "--with-filename",
	  "--line-number",
	  "--column",
	  "--smart-case",
	  "--glob=!.git/*",
	  "--glob=!composer.lock",
	  "--glob=!pnpm-lock.yaml",
	  "--glob=!package-lock.json",
	  "--glob=!yarn.lock",
	},
  }
end, { desc = "Grep files (Telescope)" })

vim.keymap.set("n", "<leader>G", function()
  lga.live_grep_args {
	prompt_title = "Grep All Files",
	vimgrep_arguments = {
	  "rg",
	  "--hidden",
	  "--no-ignore",
	  "-L",
	  "--color=never",
	  "--sort=path",
	  "--no-heading",
	  "--with-filename",
	  "--line-number",
	  "--column",
	  "--smart-case",
	},
  }
end, { desc = "Grep all files (Telescope)" })

-- Optional extras
-- vim.keymap.set("n", "<leader>h", builtin.help_tags, { desc = "Help tags (Telescope)" })
-- vim.keymap.set("n", "<leader>H", builtin.lsp_document_symbols, { desc = "LSP symbols (Telescope)" })
