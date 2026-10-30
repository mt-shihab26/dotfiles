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
    -- the search is a regex, escape the selection so code like foo(bar) or a.b[1] is searched as written
    local text = require("spectre.utils").get_visual_selection():gsub("[%.%^%$%*%+%?%(%)%[%]{}|\\]", "\\%0")
    spectre.open { search_text = text }
end

return M
