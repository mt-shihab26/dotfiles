local M = {}

-- How many du processes count folders at the same time, the rest wait in a queue
local max_jobs = 8

-- How long to wait after a size comes in before redrawing, so a burst of them draws once
local redraw_delay = 30

-- size in bytes of each folder du has counted, by path
local sizes = {}

-- folders queued, being counted or counted, so each is only counted once until a change
local requested = {}

-- folders being counted that changed meanwhile, their size is thrown away and counted again
local stale = {}

-- folders waiting for a free du, in the order they were asked for (top to bottom in the tree)
local queue = {}

local running = 0
local redraw_pending = false

local function is_within(path, dir)
    return path == dir or vim.startswith(path, dir .. "/")
end

local function redraw(on_counted)
    if redraw_pending then
        return
    end
    redraw_pending = true
    vim.defer_fn(function()
        redraw_pending = false
        on_counted()
    end, redraw_delay)
end

local function pump()
    while running < max_jobs and #queue > 0 do
        local job = table.remove(queue, 1)
        running = running + 1
        -- -s: only the total, -b: apparent size in bytes like the file sizes, -0: NUL ended
        vim.system({ "du", "-sb0", job.path }, { text = false }, function(result)
            vim.schedule(function()
                running = running - 1
                if stale[job.path] then
                    stale[job.path] = nil
                else
                    -- du exits with an error on folders it can't read, but still prints the total
                    local size = (result.stdout or ""):match "^(%d+)\t"
                    sizes[job.path] = tonumber(size)
                end
                redraw(job.on_counted)
                pump()
            end)
        end)
    end
end

-- the size of the folder at `path` in bytes, nil until it's counted; asking queues a du for it in
-- the background, each folder is counted on its own and `on_counted` runs as soon as it's done
function M.get(path, on_counted)
    if sizes[path] then
        return sizes[path]
    end
    if requested[path] then
        return nil
    end
    requested[path] = true
    queue[#queue + 1] = { path = path, on_counted = on_counted }
    pump()
    return nil
end

-- drop the folders still waiting for a du, the ones already running finish and keep their size
function M.stop()
    for _, job in ipairs(queue) do
        requested[job.path] = nil
    end
    queue = {}
end

-- forget the size of `path` and every folder above it, they all change with it; they're counted
-- again the next time they're shown
function M.changed(path)
    for dir in pairs(requested) do
        if is_within(path, dir) then
            requested[dir] = nil
            if sizes[dir] then
                sizes[dir] = nil
            else
                -- queued or being counted: drop it from the queue, or throw away what du returns
                stale[dir] = true
                for i, job in ipairs(queue) do
                    if job.path == dir then
                        table.remove(queue, i)
                        stale[dir] = nil
                        break
                    end
                end
            end
        end
    end
end

return M
