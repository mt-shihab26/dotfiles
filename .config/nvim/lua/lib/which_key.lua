local M = {}

function M.show_buffer_local()
    local which_key = require "which-key"
    which_key.show { global = false }
end

return M
