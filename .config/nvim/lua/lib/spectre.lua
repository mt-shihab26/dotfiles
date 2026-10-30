local M = {}

function M.search_buffer()
    local spectre = require "spectre"
    spectre.open_file_search { select_word = true }
end

function M.search_word()
    local spectre = require "spectre"
    spectre.open_visual { select_word = true }
end

function M.search_selection()
    -- spectre reads the selection from the '< and '> marks, which are only set once visual mode is left, so leave it
    -- first, otherwise it gets the previous selection (or nothing, the first time)
    vim.cmd.normal { "\27", bang = true }
    local spectre = require "spectre"
    spectre.open_visual()
end

return M
