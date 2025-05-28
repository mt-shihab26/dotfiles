return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
		-- {
		-- 	"3rd/image.nvim",
		-- 	build = false,
		-- 	opts = {
		-- 		processor = "magick_cli",
		-- 	},
		-- },
	},
	cmd = "Neotree",
	keys = {
		{ "<leader>e", "<cmd>Neotree action=focus<cr>", desc = "focus file tree (neo-tree)", remap = true },
		{ "<leader>p", "<cmd>Neotree action=close<cr>", desc = "close file tree (neo-tree)", remap = true },
	},
	opts = {
		filesystem = {
			filtered_items = {
				visible = false,
				hide_dotfiles = false,
				hide_gitignored = false,
				hide_hidden = false,
				hide_by_name = {
					--"node_modules"
				},
				hide_by_pattern = {
					--"*.meta",
					--"*/src/*/tsconfig.json",
				},
				always_show = {
					--".gitignored",
				},
				always_show_by_pattern = {
					--".env*",
				},
				never_show = {
					--".DS_Store",
					--"thumbs.db"
				},
				never_show_by_pattern = {
					--".null-ls_*",
				},
			},
			follow_current_file = {
				enabled = true,
				leave_dirs_open = true,
			},
			hijack_netrw_behavior = "open_current",
			use_libuv_file_watcher = true,
		},
	},
}
