local command = vim.api.nvim_create_user_command

local pack = require "lib.pack"

command("PackList", pack.list, { nargs = "*", desc = "list installed plugins and their status" })
command("PackCheck", pack.check, { nargs = "*", desc = "check for pending plugin updates (online)" })
command("PackUpdate", pack.update, { nargs = "*", desc = "update all plugins or specific ones" })
command("PackPrune", pack.prune, { nargs = "*", desc = "remove inactive plugins from disk" })
command("PackPurge", pack.purge, { nargs = "*", desc = "remove plugins from disk (including active)" })
