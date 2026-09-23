local M = {}

local upper = vim.fn.toupper
local lower = vim.fn.tolower

--- uppercase the first character and lowercase the rest, utf-8 aware
---
--- example: capitalize_word("hELLO") --> "Hello", capitalize_word("élan") --> "Élan"
---@param word string
---@return string
local function capitalize_word(word)
    local first = word:sub(1, vim.str_utf_end(word, 1) + 1)
    return upper(first) .. lower(word:sub(#first + 1))
end

--- split identifiers and phrases into lowercase words, understanding camelCase,
--- PascalCase, snake_case, kebab-case, dot.case, path/case and plain spaces
---
--- example: words("fooBarBaz") --> { "foo", "bar", "baz" }
--- example: words("HTTPServer_id") --> { "http", "server", "id" }
--- example: words("hello-world foo.bar") --> { "hello", "world", "foo", "bar" }
---@param text string
---@return string[]
local function words(text)
    text = text:gsub("(%l)(%u)", "%1 %2"):gsub("(%u+)(%u%l)", "%1 %2")
    local result = {}
    for word in text:gmatch "[^%s_%-%./]+" do
        result[#result + 1] = lower(word)
    end
    return result
end

--- apply a function to every item of a list and return the new list
---
--- example: map_words({ "a", "b" }, string.upper) --> { "A", "B" }
---@param list string[]
---@param fn fun(word: string): string
---@return string[]
local function map_words(list, fn)
    return vim.tbl_map(fn, list)
end

--- case styles by name, each one turns a piece of text into that style
---
--- example: converters.upper("hello world")      --> "HELLO WORLD"
--- example: converters.lower("Hello World")      --> "hello world"
--- example: converters.capitalize("hello wORLD") --> "Hello World"
--- example: converters.snake("helloWorld")       --> "hello_world"
--- example: converters.kebab("hello_world")      --> "hello-world"
--- example: converters.dot("hello world")        --> "hello.world"
--- example: converters.constant("helloWorld")    --> "HELLO_WORLD"
--- example: converters.pascal("hello_world")     --> "HelloWorld"
--- example: converters.camel("hello-world")      --> "helloWorld"
---@type table<string, fun(text: string): string>
local converters = {
    upper = upper,
    lower = lower,
    capitalize = function(text)
        return (text:gsub("%S+", capitalize_word))
    end,
    snake = function(text)
        return table.concat(words(text), "_")
    end,
    kebab = function(text)
        return table.concat(words(text), "-")
    end,
    dot = function(text)
        return table.concat(words(text), ".")
    end,
    constant = function(text)
        return upper(table.concat(words(text), "_"))
    end,
    pascal = function(text)
        return table.concat(map_words(words(text), capitalize_word))
    end,
    camel = function(text)
        local list = words(text)
        for i = 2, #list do
            list[i] = capitalize_word(list[i])
        end
        return table.concat(list)
    end,
}

--- sorted names of all supported case styles, used for completion and error messages
---
--- example: M.kinds --> { "camel", "capitalize", "constant", "dot", "kebab", "lower", "pascal", "snake", "upper" }
---@type string[]
M.kinds = vim.tbl_keys(converters)
table.sort(M.kinds)

--- convert text while leaving surrounding whitespace untouched, so selections that
--- include a trailing space or newline do not get glued to the next word
---
--- example: convert_text("snake", "  fooBar ") --> "  foo_bar "
--- example: convert_text("upper", "   ")       --> "   "
---@param kind string one of M.kinds
---@param text string
---@return string
local function convert_text(kind, text)
    local lead, body, trail = text:match "^(%s*)(.-)(%s*)$"
    if body == "" then
        return text
    end
    return lead .. converters[kind](body) .. trail
end

--- convert every line segment covered by the region between two positions
---
--- charwise, linewise and blockwise regions are all supported, each line of the
--- region is converted on its own so a block only changes its selected columns
---
--- example: kind "kebab", "hello world" selected with `V` --> "hello-world"
--- example: kind "upper", block over columns 1-2 of "abc" and "def" --> "ABc" and "DEf"
---@param kind string one of M.kinds
---@param pos1 integer[] start position as returned by getpos()
---@param pos2 integer[] end position as returned by getpos()
---@param mode string "v" (charwise), "V" (linewise) or "\22" (blockwise)
local function convert_region(kind, pos1, pos2, mode)
    local bufnr = vim.api.nvim_get_current_buf()
    local segments = vim.fn.getregionpos(pos1, pos2, { type = mode, exclusive = false })

    -- apply bottom-up so earlier edits do not shift later positions
    for i = #segments, 1, -1 do
        local from, to = segments[i][1], segments[i][2]
        local line = vim.api.nvim_buf_get_lines(bufnr, to[2] - 1, to[2], false)[1] or ""
        local start_col = from[3] - 1
        local end_col = to[3] - 1
        if to[3] > 0 and to[3] <= #line then
            end_col = end_col + vim.str_utf_end(line, to[3]) + 1
        end

        if end_col > start_col then
            local text = vim.api.nvim_buf_get_text(bufnr, from[2] - 1, start_col, to[2] - 1, end_col, {})
            local converted = convert_text(kind, table.concat(text, "\n"))
            vim.api.nvim_buf_set_text(bufnr, from[2] - 1, start_col, to[2] - 1, end_col, vim.split(converted, "\n"))
        end
    end
end

--- convert the last visual selection (or the given line range when the command
--- was not run from a selection) using the case style in the command argument,
--- with no range it converts the word under the cursor
---
--- example: `:'<,'>Case kebab` on the selection "helloWorld" --> "hello-world"
--- example: `:Case upper` with the cursor on "hello" in "hello world" --> "HELLO world"
--- example: `:Case nope` --> error listing the supported styles
---@param opts { args: string, range: integer, line1: integer, line2: integer } user command options
function M.convert(opts)
    local kind = opts.args
    if not converters[kind] then
        vim.notify(
            "Unknown case '" .. tostring(kind) .. "', use one of: " .. table.concat(M.kinds, ", "),
            vim.log.levels.ERROR
        )
        return
    end

    local start = vim.fn.getpos "'<"
    local finish = vim.fn.getpos "'>"
    local from_visual = opts.range > 0 and start[2] == opts.line1 and finish[2] == opts.line2

    if from_visual then
        convert_region(kind, start, finish, vim.fn.visualmode())
    elseif opts.range > 0 then
        convert_region(kind, { 0, opts.line1, 1, 0 }, { 0, opts.line2, #vim.fn.getline(opts.line2), 0 }, "V")
    else
        -- no range: convert the word under the cursor
        local pos = vim.fn.getpos "."
        local line = vim.api.nvim_get_current_line()
        local s = vim.fn.matchstrpos(line, [[\k*\%]] .. pos[3] .. [[c\k*]])
        if s[2] < 0 or s[1] == "" then
            return
        end
        convert_region(kind, { 0, pos[2], s[2] + 1, 0 }, { 0, pos[2], s[3], 0 }, "v")
    end
end

--- build a visual mode keymap handler for a case style, it leaves visual mode
--- first so the '< and '> marks are set, then converts the selection
---
--- example: vim.keymap.set("v", "<leader>uk", M.visual "kebab")
---          selecting "helloWorld" and pressing <leader>uk --> "hello-world"
---@param kind string one of M.kinds
---@return fun()
function M.visual(kind)
    return function()
        vim.cmd "normal! \27"
        local start = vim.fn.getpos "'<"
        local finish = vim.fn.getpos "'>"
        convert_region(kind, start, finish, vim.fn.visualmode())
    end
end

--- command completion for the :Case argument, offers the styles starting with
--- what has been typed so far
---
--- example: M.complete("ca") --> { "camel", "capitalize" }
--- example: M.complete("")   --> all of M.kinds
---@param arglead string
---@return string[]
function M.complete(arglead)
    return vim.tbl_filter(function(kind)
        return vim.startswith(kind, arglead)
    end, M.kinds)
end

return M
