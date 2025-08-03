require("neo-tree").setup(
 {
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
}
)
