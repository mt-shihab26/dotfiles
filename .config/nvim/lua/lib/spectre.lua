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

-- rg, sed and vim's \v (the preview) all read the search as a regex; escaping these makes them match it as written.
-- < > = are left out, spectre escapes them for vim itself and they're plain characters to rg and sed
local function escape_search(text)
    return (text:gsub("[%.%^%$%*%+%?%(%)%[%]{}|\\%%@&~]", "\\%0"))
end

-- sed and vim read \ & ~ in the replacement as references to the match, escaped they're inserted as written
local function escape_replace(text)
    return (text:gsub("[\\&~]", "\\%0"))
end

-- search and replace text as written, never as a regex: every query spectre runs goes through search or
-- async_replace, which get the escaped query; the text as typed is kept in `typed` for when it's shown again
function M.disable_regex()
    local spectre = require "spectre"
    local state = require "spectre.state"

    local function literal(query)
        if not query or query.typed then
            return query
        end
        return vim.tbl_extend("force", query, {
            search_query = escape_search(query.search_query or ""),
            replace_query = escape_replace(query.replace_query or ""),
            typed = { search_query = query.search_query, replace_query = query.replace_query },
        })
    end

    for _, name in ipairs { "search", "async_replace" } do
        local original = spectre[name]
        spectre[name] = function(query)
            return original(literal(query))
        end
    end

    -- resuming puts the last query back in the panel, which should show it as typed and not escaped
    local resume = spectre.resume_last_search
    spectre.resume_last_search = function()
        local backup = state.query_backup
        if backup and backup.typed then
            backup = vim.tbl_extend("force", backup, backup.typed)
            backup.typed = nil
            state.query_backup = backup
        end
        resume()
    end
end

return M
