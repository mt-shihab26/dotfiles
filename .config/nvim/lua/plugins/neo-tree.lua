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

        local folder_size = require "lib.folder_size"
        local utils = require "neo-tree.utils"
        local highlights = require "neo-tree.ui.highlights"

        folder_size.on_update = function()
            manager.redraw "filesystem"
        end

        -- 3 digit whole numbers with a lowercase unit right after them ("023kb"), 1024 to a unit like
        -- neo-tree; a size needing a 4th digit goes up a unit, 1012kb is shown as 001mb
        local units = { "b", "kb", "mb", "gb", "tb", "pb" }
        local function human_size(size)
            local unit = 1
            while unit < #units and math.floor(size + 0.5) >= 1000 do
                size = size / 1024
                unit = unit + 1
            end
            return ("%03d%s"):format(math.floor(size + 0.5), units[unit])
        end

        -- writes in folders the tree isn't watching, e.g. a file opened from telescope
        vim.api.nvim_create_autocmd("BufWritePost", {
            callback = function(args)
                -- args.match is the full path of the file written
                folder_size.changed(vim.fs.dirname(args.match))
            end,
        })
        -- another project: free the sizes of the old one
        vim.api.nvim_create_autocmd("DirChanged", {
            callback = function()
                folder_size.clear()
            end,
        })
        -- keep the sizes shown for the next session (see lib/folder_size.lua)
        vim.api.nvim_create_autocmd("VimLeavePre", {
            callback = folder_size.save,
        })

        neo_tree.setup {
            default_component_configs = {
                -- human readable ("023kb", always 5 wide), shown at any window width instead of only from 64 columns
                file_size = { enabled = true, width = 5, required_width = 0 },
                type = { enabled = false },
                last_modified = { enabled = false },
                created = { enabled = false },
            },
            window = {
                width = 45, -- a little wider than the default 40, to fit the size column
                mappings = {
                    -- <space> is also <leader>, so it can fire after the tree lost its window, and nui's
                    -- get_node then errors with "Invalid 'win'"; only toggle while the tree is on screen
                    ["<space>"] = {
                        function(state)
                            if state.tree and #vim.fn.win_findbuf(state.tree.bufnr) > 0 then
                                state.commands.toggle_node(state)
                            end
                        end,
                        nowait = false,
                        desc = "toggle_node",
                    },
                },
            },
            event_handlers = {
                -- new C/C++ headers start with "#pragma once" (see lib/header.lua)
                {
                    event = "file_added",
                    handler = function(path)
                        require("lib.header").add_pragma_once(path)
                    end,
                },
                -- a change in a watched (expanded) folder changes its size and the size of every folder above it
                {
                    event = "fs_event",
                    handler = function(args)
                        folder_size.changed(args.afile)
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
                    -- no "Size" header on the root line, and sizes left aligned within the column, rounded
                    -- with lowercase units right after the number ("023kb", see human_size above)
                    file_size = function(config, node, state)
                        -- vim.g.tree_sizes off (options.lua, <leader>tS): no sizes, and no du runs
                        if node:get_depth() == 1 or not vim.g.tree_sizes then
                            return { text = "" }
                        end
                        -- sized here and not by neo-tree's own component, which has decimals ("497.86 KB") and
                        -- cuts them to the column width
                        local size
                        if node.type == "directory" then
                            -- "-" until du has counted it in the background (see lib/folder_size.lua)
                            size = folder_size.get(node.path)
                        elseif node.type == "file" then
                            local stat = utils.get_stat(node)
                            size = stat and stat.size
                        end
                        local text = size and human_size(size) or "-"
                        return {
                            text = text .. (" "):rep(config.width - #text + 2),
                            highlight = config.highlight or highlights.FILE_STATS,
                        }
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
