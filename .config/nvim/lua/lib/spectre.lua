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
    local spectre = require "spectre"
    spectre.open_visual()
end

return M
