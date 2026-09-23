local cmd = vim.api.nvim_create_user_command

local pack = require "lib.pack"

cmd("PackList", pack.list, { nargs = "*", desc = "list installed plugins and their status" })
cmd("PackCheck", pack.check, { nargs = "*", desc = "check for pending plugin updates (online)" })
cmd("PackUpdate", pack.update, { nargs = "*", desc = "update all plugins or specific ones" })
cmd("PackPrune", pack.prune, { nargs = "*", desc = "remove inactive plugins from disk" })
cmd("PackPurge", pack.purge, { nargs = "*", desc = "remove plugins from disk (including active)" })

local toggle = require "lib.toggle"

cmd("FormatToggle", toggle.format_on_save, { desc = "toggle format on save" })
cmd("FormatDisable", toggle.format_disable, { desc = "disable format on save", bar = true })

cmd("Wa", toggle.write_all_no_format, { desc = "write all buffers without formatting" })

local case = require "lib.case"

local caseDesc = "convert text case: upper, lower, capitalize, snake, kebab, dot, constant, pascal, camel";

cmd("Case", case.convert, { nargs = 1, range = true, complete = case.complete, desc = caseDesc })
