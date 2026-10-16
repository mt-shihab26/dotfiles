-- shared with telescope, spectre, bufferline and lualine, so they're on the runtimepath from the start
vim.pack.add {
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
    -- plugins/lspconfig.lua takes its capabilities, its setup below hooks neo-tree's renames and moves
    {
        src = "https://github.com/antosha417/nvim-lsp-file-operations",
        version = vim.version.range "1",
    },
}

local lazy = require "lib.lazy"

-- loads on the first :Neotree (<leader>e)
lazy.add({
    {
        src = "https://github.com/nvim-neo-tree/neo-tree.nvim",
        version = vim.version.range "3",
    },
}, {
    modules = { "neo-tree" },
    commands = { "Neotree" },
    setup = function()
        local neo_tree = require "neo-tree"

        -- a buffer whose file was deleted outside neovim can't be revealed; scanning its missing
        -- folder makes neo-tree error on focus/follow, so reveal nothing for it
        local manager = require "neo-tree.sources.manager"
        local get_path_to_reveal = manager.get_path_to_reveal
        manager.get_path_to_reveal = function(...)
            local path = get_path_to_reveal(...)
            if path and not vim.uv.fs_stat(path) then
                return nil
            end
            return path
        end

        neo_tree.setup {
            default_component_configs = {
                file_size = { enabled = false },
                type = { enabled = false },
                last_modified = { enabled = false },
                created = { enabled = false },
            },
            event_handlers = {
                -- new C/C++ headers start with "#pragma once" (see lib/header.lua)
                {
                    event = "file_added",
                    handler = function(path)
                        require("lib.header").add_pragma_once(path)
                    end,
                },
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
                    hide_ignored = false,
                    hide_hidden = false,
                    hide_by_name = {},
                    always_show = { ".DS_Store" },
                    never_show = { ".git" },
                },
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = true,
                },
            },
        }

        -- tell the language servers about files renamed or moved in neo-tree, so they update imports
        require("lsp-file-operations").setup {}
    end,
})
