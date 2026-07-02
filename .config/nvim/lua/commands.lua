local pack = require "utils.pack"

vim.api.nvim_create_user_command(
    "PackList",
    pack.list,
    { nargs = "*", desc = "list installed plugins and their status" }
)
vim.api.nvim_create_user_command(
    "PackCheck",
    pack.check,
    { nargs = "*", desc = "check for pending plugin updates (online)" }
)
vim.api.nvim_create_user_command(
    "PackUpdate",
    pack.update,
    { nargs = "*", desc = "update all plugins or specific ones" }
)
vim.api.nvim_create_user_command("PackClean", pack.clean, { nargs = "*", desc = "remove inactive plugins from disk" })
vim.api.nvim_create_user_command(
    "PackRemoveAll",
    pack.remove_all,
    { nargs = "*", desc = "remove plugins from disk (including active)" }
)
