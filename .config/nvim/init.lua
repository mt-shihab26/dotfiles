require("vim._core.ui2").enable {}

-- Missing plugins should just install, never block on a confirmation prompt.
local pack_add = vim.pack.add
vim.pack.add = function(specs, opts)
    return pack_add(specs, vim.tbl_extend("force", { confirm = false }, opts or {}))
end

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require "options"
require "keymaps"
require "plugins"
require "commands"
