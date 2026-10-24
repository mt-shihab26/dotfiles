local M = {}

-- How many du processes count folders at the same time, the rest wait in a queue
local max_jobs = 8

-- How long to wait after a size comes in before redrawing, so a burst of them draws once
local redraw_delay = 30

-- How long changes have to stop before the folders they touched are counted again, so a build or
-- an install writing files nonstop doesn't start counting over on every file
local settle_delay = 500

-- How many levels of folders below a counted one du reports sizes for; du reads the whole tree
-- either way, deeper folders are counted with their own du when opened, which keeps a tree opened
-- at a huge folder like ~ from holding the size of every folder in it
local max_depth = 3

-- size in bytes of each folder du has counted, by path; false when du couldn't count it
local sizes = {}

-- folders whose size is out of date, by path, with the change number that made them so; they
-- keep showing the old size until they're counted again
local outdated = {}

-- folders queued or being counted
local requested = {}

-- folders waiting for a free du, in the order they were asked for (top to bottom in the tree)
local queue = {}

-- counts every batch of changes, so a du that started before one doesn't mark its folders as up to date
local change = 0

-- folders changed since the last batch, applied once changes settle
local changes = {}

local running = 0

-- bumped when everything is dropped, so a du still running then doesn't store its sizes
local epoch = 0
local redraw_pending = false
local settle_timer = assert(vim.uv.new_timer())

-- redraws the tree, the latest callback given to get()
local on_update = function() end

local function redraw()
    if redraw_pending then
        return
    end
    redraw_pending = true
    vim.defer_fn(function()
        redraw_pending = false
        on_update()
    end, redraw_delay)
end

-- up to date when counted and not changed since
local function is_current(path)
    return sizes[path] ~= nil and not outdated[path]
end

local function store(path, size, started)
    sizes[path] = size
    -- a change after this du started still needs a recount
    if outdated[path] and outdated[path] <= started then
        outdated[path] = nil
    end
end

-- a folder above `path` is queued or being counted, its du will likely count `path` too
local function has_requested_parent(path)
    local dir = vim.fs.dirname(path)
    while dir ~= path do
        if requested[dir] then
            return true
        end
        path, dir = dir, vim.fs.dirname(dir)
    end
    return false
end

local function pump()
    local i = 1
    while running < max_jobs and i <= #queue do
        local path = queue[i]
        if is_current(path) then
            -- counted meanwhile by a du of a folder above it
            table.remove(queue, i)
            requested[path] = nil
        elseif has_requested_parent(path) then
            -- wait for that du instead of reading the same files twice at once
            i = i + 1
        else
            table.remove(queue, i)
            running = running + 1
            local started, started_epoch = change, epoch
            -- no -s: du walks the same files either way, and printing the folders below costs
            -- nothing extra, so opening them later shows their size right away without a du;
            -- -b: apparent size in bytes like the file sizes, -0: NUL ended, as names can hold newlines
            vim.system({ "du", "-b0", "--max-depth=" .. max_depth, path }, { text = false }, function(result)
                vim.schedule(function()
                    running = running - 1
                    -- everything was dropped meanwhile
                    if started_epoch ~= epoch then
                        pump()
                        return
                    end
                    requested[path] = nil
                    -- du exits with an error on folders it can't read, but still prints the rest
                    for line in (result.stdout or ""):gmatch "%Z+" do
                        local size, dir = line:match "^(%d+)\t(.*)$"
                        if size then
                            store(dir, tonumber(size), started)
                        end
                    end
                    if sizes[path] == nil then
                        store(path, false, started)
                    end
                    redraw()
                    pump()
                end)
            end)
        end
    end
end

-- the size of the folder at `path` in bytes, nil until it's counted; asking queues a du for it in
-- the background, and `update` (which redraws the tree) runs as soon as it's done. Out of date
-- folders keep returning their old size while they're counted again.
function M.get(path, update)
    on_update = update
    if not is_current(path) and not requested[path] then
        requested[path] = true
        queue[#queue + 1] = path
        pump()
    end
    return sizes[path] or nil
end

-- drop every size and every folder waiting for a du, freeing their memory; used when sizes are
-- turned off and when the working directory changes, as the old project's sizes won't be shown
function M.clear()
    epoch = epoch + 1
    sizes, outdated, requested, queue, changes = {}, {}, {}, {}, {}
    settle_timer:stop()
end

local function apply_changes()
    change = change + 1
    for path in pairs(changes) do
        -- the folder and every folder above it change with it, the ones below don't
        local dir = path
        while dir do
            if sizes[dir] ~= nil then
                outdated[dir] = change
            end
            local parent = vim.fs.dirname(dir)
            dir = parent ~= dir and parent or nil
        end
    end
    changes = {}
    redraw()
end

-- something in the folder at `path` changed; once changes stop for `settle_delay`, it and every
-- folder above it are counted again
function M.changed(path)
    changes[path] = true
    settle_timer:stop()
    settle_timer:start(settle_delay, 0, vim.schedule_wrap(apply_changes))
end

return M
