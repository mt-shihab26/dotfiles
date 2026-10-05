vim.pack.add {
    {
        src = "https://github.com/nvim-neo-tree/neo-tree.nvim",
        version = vim.version.range "3",
    },
    {
        src = "https://github.com/nvim-lua/plenary.nvim",
        version = vim.version.range "0.1",
    },
    {
        src = "https://github.com/MunifTanjim/nui.nvim",
        version = vim.version.range "0.4",
    },
    {
        src = "https://github.com/nvim-tree/nvim-web-devicons",
        version = "master",
    },
}

local neo_tree = require "neo-tree"

neo_tree.setup {
    default_component_configs = {
        file_size = { enabled = false },
        type = { enabled = false },
        last_modified = { enabled = false },
        created = { enabled = false },
    },
    filesystem = {
        components = {
            name = function(config, node, state)
                local result = require("neo-tree.sources.filesystem.components").name(config, node, state)
                if node:get_depth() == 1 and node.type ~= "message" then
                    if state._in_pre_render then
                        -- keep the root (cwd) path out of the auto-expand width measurement
                        result.text = ""
                    else
                        -- show the root as ~/--/--/folder, hiding the middle folders
                        local parts = vim.split(node.name, "/", { plain = true })
                        for i = 2, #parts - 1 do
                            parts[i] = "--"
                        end
                        result.text = table.concat(parts, "/") .. result.text:sub(#node.name + 1)
                    end
                end
                return result
            end,
        },
        use_libuv_file_watcher = true,
        hijack_netrw_behavior = "disabled",
        filtered_items = {
            visible = false,
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_hidden = false,
            always_show = { ".DS_Store" },
            never_show = { ".git" },
        },
        follow_current_file = {
            enabled = true,
            leave_dirs_open = true,
        },
    },
}
