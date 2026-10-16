local M = {}

function M.lazygit()
    vim.cmd "LazyGit"
end

-- jump between hunks without the "Hunk 1 of 3" message
---@param direction "next"|"prev"
---@param target "unstaged"|"staged"
local function nav_hunk(direction, target)
    local gitsigns = require "gitsigns"
    gitsigns.nav_hunk(direction, { target = target, navigation_message = false })
end

function M.next_hunk()
    nav_hunk("next", "unstaged")
end

function M.prev_hunk()
    nav_hunk("prev", "unstaged")
end

function M.next_staged_hunk()
    nav_hunk("next", "staged")
end

function M.prev_staged_hunk()
    nav_hunk("prev", "staged")
end

return M
