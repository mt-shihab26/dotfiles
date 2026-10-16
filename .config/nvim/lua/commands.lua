local cmd = vim.api.nvim_create_user_command

local pack = require "lib.pack"

cmd("PackList", pack.list, { nargs = "*", desc = "list installed plugins and their status" })
cmd("PackCheck", pack.check, { nargs = "*", desc = "check for pending plugin updates (online)" })
cmd("PackUpdate", pack.update, { nargs = "*", desc = "update all plugins or specific ones" })
cmd("PackPrune", pack.prune, { nargs = "*", desc = "remove inactive plugins from disk" })
cmd("PackPurge", pack.purge, { nargs = "*", desc = "remove plugins from disk (including active)" })
