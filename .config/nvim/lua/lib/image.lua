local M = {}

-- Cells the border takes on each side of the image
local border_size = 1

-- Highlight group the border is drawn with
local border_hl = "FloatBorder"

-- How far the image's aspect ratio may drift from the real one after rounding to whole cells
local ratio_tolerance = 0.02

-- Smallest fraction of the fitting size to shrink to while looking for a better aspect ratio
local min_scale = 0.75

-- Snacks writes each image cell as a placeholder character followed by two diacritics encoding its row and column
local chars_per_cell = 3

-- Snacks can only encode this many rows and columns of image cells
local max_cells = 297

-- How much each zoom in or out scales the image
local zoom_step = 1.2

-- Fraction of the window each hjkl press moves a zoomed image by
local pan_step = 0.1

-- Mouse pointer shown while dragging an image, a CSS cursor name the terminal understands
local drag_pointer = "grabbing"

-- Lua has no round(), and a 0 cell image can't be placed
local function round(n)
    return math.max(1, math.floor(n + 0.5))
end

-- Snacks shows image files in buffers with this filetype, the only ones changed here
local function is_image(buf)
    return vim.bo[buf].filetype == "image"
end

-- Offset that centers a bordered image of `size` cells within `area` cells
local function center(area, size)
    return math.max(0, math.floor((area - size - 2 * border_size) / 2))
end

-- The first of `size` image cells to show in `area` cells: the middle ones, moved `pan` cells
-- but never past the image's edge. Also returns the pan that was actually applied.
local function visible_start(size, area, pan)
    local centered = math.floor((size - area) / 2)
    local start = math.max(0, math.min(size - area, centered + pan))
    return start, start - centered
end

-- A horizontal border line spanning `width` image cells between two corners
local function border_line(left, right, width)
    return { left .. ("─"):rep(width) .. right, border_hl }
end

-- Snacks sizes images in whole cells, so a small image can get stretched by the rounding.
-- Find the largest whole-cell size inside the window that keeps the aspect ratio within a
-- small tolerance. It's fine to leave some space unused when no exact size fits, but only
-- shrink down to 3/4 of the window looking for one, then settle for the closest ratio.
---@param ratio number width / height of the image in cells
local function contain_cells(ratio, max_width, max_height)
    local width = math.max(1, math.min(max_width, math.floor(max_height * ratio)))
    local best, best_error
    for w = width, math.ceil(width * min_scale), -1 do
        local size = { width = w, height = math.min(max_height, round(w / ratio)) }
        local err = math.abs(size.width / size.height - ratio) / ratio
        if err <= ratio_tolerance then
            return size
        end
        if not best_error or err < best_error then
            best, best_error = size, err
        end
    end
    return best
end

-- Snacks only shrinks large images to fit the window. For image buffers, also scale small
-- images up so they always fill the window's width or height (like css `object-fit: contain`),
-- then scale that by the image's zoom level.
local function contain_images(image)
    local util = image.util
    local placement = image.placement

    local fit = util.fit
    local state = placement.state
    -- the image placement being sized, if it is an image buffer
    local current

    util.fit = function(file, cells, opts)
        if not current then
            return fit(file, cells, opts)
        end
        local info = opts and opts.info
        local pixels = info
            and { width = info.size.width / info.dpi.width, height = info.size.height / info.dpi.height }
            or util.dim(file)
        local cell = image.terminal.size()
        local ratio = (pixels.width / pixels.height) * (cell.cell_height / cell.cell_width)
        -- leave room for the border around the image
        local room = 2 * border_size
        local max_width, max_height = math.max(1, cells.width - room), math.max(1, cells.height - room)
        local base = contain_cells(ratio, max_width, max_height)
        -- keep the zoom where it changes the image: at least 1 cell and at most what snacks can encode.
        -- The limits depend on the window size, so only clamp here and remember them for the next
        -- zoom step, leaving the requested zoom as is for when the window is resized.
        current.zoom_limits = {
            min = 1 / math.min(base.width, base.height),
            max = max_cells / math.max(base.width, base.height),
        }
        local zoom = math.max(current.zoom_limits.min, math.min(current.zoom or 1, current.zoom_limits.max))
        if zoom == 1 then
            return base
        end
        local function scale(n)
            return math.min(max_cells, math.max(1, math.floor(n * zoom)))
        end
        return contain_cells(ratio, scale(max_width), scale(max_height))
    end

    placement.state = function(self, ...)
        current = is_image(self.buf) and self or nil
        local ok, result = pcall(state, self, ...)
        current = nil
        if not ok then
            error(result, 0)
        end
        return result
    end
end

-- Snacks hides an image once its buffer leaves every window, but only inline docs ever show
-- it again. Un-hide image buffers when they are displayed so switching back re-renders them.
local function reshow_images(image)
    local placement = image.placement

    local state = placement.state

    placement.state = function(self, ...)
        if is_image(self.buf) and self.hidden and #self:wins() > 0 then
            self.hidden = false
        end
        return state(self, ...)
    end
end

-- Size of the smallest window showing the buffer, measured the same way snacks sizes the image
local function win_area(placement)
    local width, height = vim.o.columns, vim.o.lines
    for _, win in ipairs(placement:wins()) do
        width = math.min(width, vim.api.nvim_win_get_width(win))
        height = math.min(height, vim.api.nvim_win_get_height(win))
    end
    return width, height
end

-- The image rows snacks renders, as highlight chunks: an overlay on the first line plus virtual
-- lines for the rest, or a single inline row for images one cell tall.
local function image_rows(extmarks)
    local first, rest = extmarks[1], extmarks[2]
    if not (first and first.virt_text) then
        return
    end
    if #extmarks == 1 and first.virt_text_pos == "inline" then
        return { first.virt_text[1] }
    elseif #extmarks == 2 and rest.virt_lines then
        local rows = { first.virt_text[1] }
        for _, line in ipairs(rest.virt_lines) do
            rows[#rows + 1] = line[2]
        end
        return rows
    end
end

-- Draw a square border around image buffers and center them in the window. Snacks renders the
-- first image row over the buffer's only line and the remaining rows as virtual lines below it,
-- so the top border takes the place of that first row and everything else moves down into the
-- virtual lines. Centering pads the left with spaces and the top with blank virtual lines.
local function border_images(image)
    local placement = image.placement

    local render = placement._render
    local state = placement.state

    -- Snacks skips re-rendering when the image size is unchanged, but resizing the window
    -- still moves the center and panning moves the visible part, so add both to the state.
    placement.state = function(self, ...)
        local result = state(self, ...)
        if is_image(self.buf) then
            local width, height = win_area(self)
            result.area = { width = width, height = height }
            result.pan = self.pan and { x = self.pan.x, y = self.pan.y }
        end
        return result
    end

    placement._render = function(self, extmarks)
        local rows = is_image(self.buf) and image_rows(extmarks)
        if rows then
            local first = extmarks[1]
            local bar = { ("│"):rep(border_size), border_hl }
            -- measure the rendered rows, as snacks caps them at the number of cell positions
            -- it can encode, which can be less than the size in the state
            local width, height = vim.fn.strchars(rows[1][1]) / chars_per_cell, #rows
            local area_width, area_height = win_area(self)
            -- a zoomed in image can be larger than the window, so show only the part panned to,
            -- keeping the pan within the image so moving back responds right away
            local max_width = math.max(1, area_width - 2 * border_size)
            local max_height = math.max(1, area_height - 2 * border_size)
            local pan = self.pan or { x = 0, y = 0 }
            self.pan = pan
            if width > max_width then
                local skip
                skip, pan.x = visible_start(width, max_width, pan.x)
                for i, cells in ipairs(rows) do
                    local text = vim.fn.strcharpart(cells[1], skip * chars_per_cell, max_width * chars_per_cell)
                    rows[i] = { text, cells[2] }
                end
                width = max_width
            else
                pan.x = 0
            end
            if height > max_height then
                local skip
                skip, pan.y = visible_start(height, max_height, pan.y)
                rows = vim.list_slice(rows, skip + 1, skip + max_height)
                height = max_height
            else
                pan.y = 0
            end
            local left, top = center(area_width, width), center(area_height, height)
            local pad = { (" "):rep(left) }
            local lines = {}
            for i, cells in ipairs(rows) do
                lines[i] = { pad, bar, cells, bar }
            end
            lines[#lines + 1] = { pad, border_line("└", "┘", width) }
            first.virt_text = { border_line("┌", "┐", width) }
            first.virt_text_pos = "overlay"
            first.virt_text_hide = false
            first.virt_text_win_col = left
            extmarks = { first, { row = first.row, col = 0, virt_lines = lines, virt_text_hide = false } }
            if top > 0 then
                local blank = {}
                for i = 1, top do
                    blank[i] = { { "" } }
                end
                extmarks[#extmarks + 1] = { row = first.row, col = 0, virt_lines = blank, virt_lines_above = true }
            end
            -- snacks leaves its last "loading …" spinner on the line once the image is ready,
            -- which shows next to the centered image, so clear it before drawing
            vim.api.nvim_buf_clear_namespace(self.buf, placement.ns, 0, -1)
            render(self, extmarks)
            -- windows keep their old count of virtual lines shown above the first line when the
            -- padding changes, which pushes the image to the top, so scroll them all into view
            for _, win in ipairs(self:wins()) do
                vim.api.nvim_win_call(win, function()
                    vim.fn.winrestview { topline = 1, topfill = top }
                end)
            end
            return
        end
        return render(self, extmarks)
    end
end

-- Zoom image buffers in and out with the scroll wheel (or a trackpad) and with shift + / shift -,
-- move around a zoomed image with hjkl or by dragging it, and reset both with r.
-- The zoom and pan live on the placement, so reopening the image resets them. r stays a
-- reset rather than replace, since image buffers are not modifiable.
local function zoom_images(image)
    local placement = image.placement

    local new = placement.new

    -- the placement of each image buffer, so the scroll wheel can find the image under the mouse
    local images = {}

    -- Scale the zoom by `factor`, starting from the last zoom the image could show so that
    -- zooming past a limit doesn't need as many steps back before the image changes again
    local function zoom(self, factor)
        local limits = self.zoom_limits
        local current = self.zoom or 1
        local target = current * factor
        if limits then
            current = math.max(limits.min, math.min(current, limits.max))
            target = current * factor
            factor = math.max(limits.min, math.min(target, limits.max)) / current
        end
        self.zoom = target
        -- scale the pan with the image so the same part stays in the middle of the window
        if self.pan then
            self.pan = { x = math.floor(self.pan.x * factor + 0.5), y = math.floor(self.pan.y * factor + 0.5) }
        end
        self:update()
    end

    -- Move the visible part of a zoomed image by `dx`, `dy` cells
    local function pan(self, dx, dy)
        local current = self.pan or { x = 0, y = 0 }
        self.pan = { x = current.x + dx, y = current.y + dy }
        self:update()
    end

    -- The wheel zooms the image under the mouse even when its window isn't focused, so map it
    -- everywhere and scroll other windows as usual.
    local function map_wheel(lhs, factor, desc)
        vim.keymap.set("n", lhs, function()
            local win = vim.fn.getmousepos().winid
            local self = win ~= 0 and images[vim.api.nvim_win_get_buf(win)]
            if self and not self.closed then
                zoom(self, factor)
            else
                vim.api.nvim_feedkeys(vim.keycode(lhs), "n", false)
            end
        end, { desc = desc })
    end

    map_wheel("<ScrollWheelUp>", zoom_step, "Scroll up, or zoom in the image under the mouse")
    map_wheel("<ScrollWheelDown>", 1 / zoom_step, "Scroll down, or zoom out the image under the mouse")

    placement.new = function(buf, ...)
        local self = new(buf, ...)
        if not is_image(buf) then
            return self
        end
        images[buf] = self
        vim.api.nvim_create_autocmd("BufWipeout", {
            buffer = buf,
            once = true,
            callback = function()
                images[buf] = nil
            end,
        })

        local function map(lhs, factor, desc)
            vim.keymap.set("n", lhs, function()
                zoom(self, factor)
            end, { buffer = buf, desc = desc })
        end

        map("+", zoom_step, "Zoom image in")
        map("_", 1 / zoom_step, "Zoom image out")

        local function map_pan(lhs, dx, dy, desc)
            vim.keymap.set("n", lhs, function()
                local width, height = win_area(self)
                local step_x, step_y = math.max(1, math.floor(width * pan_step)), math.max(1, math.floor(height * pan_step))
                pan(self, dx * step_x * vim.v.count1, dy * step_y * vim.v.count1)
            end, { buffer = buf, desc = desc })
        end

        map_pan("h", -1, 0, "Move to the left of the image")
        map_pan("l", 1, 0, "Move to the right of the image")
        map_pan("k", 0, -1, "Move up the image")
        map_pan("j", 0, 1, "Move down the image")

        -- Dragging moves the image with the mouse. Clicks and drags that don't start on this
        -- image (like resizing a window) work as usual.
        local drag

        -- Set the terminal's mouse pointer (OSC 22), or reset it to the default with ""
        local function pointer(shape)
            image.terminal.write("\27]22;" .. shape .. "\27\\")
        end
        local function map_mouse(lhs, handle, desc)
            vim.keymap.set("n", lhs, function()
                if not handle(vim.fn.getmousepos()) then
                    vim.api.nvim_feedkeys(vim.keycode(lhs), "n", false)
                end
            end, { buffer = buf, desc = desc })
        end

        map_mouse("<LeftMouse>", function(mouse)
            drag = nil
            -- the image is drawn in virtual lines, so check the window rows rather than buffer lines
            local win = mouse.winid
            if win == 0 or vim.api.nvim_win_get_buf(win) ~= buf then
                return false
            end
            if mouse.winrow < 1 or mouse.winrow > vim.api.nvim_win_get_height(win) then
                return false
            end
            vim.api.nvim_set_current_win(win)
            local current = self.pan or { x = 0, y = 0 }
            drag = { col = mouse.screencol, row = mouse.screenrow, x = current.x, y = current.y }
            pointer(drag_pointer)
            return true
        end, "Start dragging the image")
        map_mouse("<LeftDrag>", function(mouse)
            if not drag then
                return false
            end
            self.pan = { x = drag.x - (mouse.screencol - drag.col), y = drag.y - (mouse.screenrow - drag.row) }
            self:update()
            return true
        end, "Drag the image")
        map_mouse("<LeftRelease>", function()
            local dragging = drag ~= nil
            drag = nil
            if dragging then
                pointer("")
            end
            return dragging
        end, "Stop dragging the image")

        vim.keymap.set("n", "r", function()
            self.zoom = 1
            self.pan = nil
            self:update()
        end, { buffer = buf, desc = "Reset image zoom" })
        return self
    end
end

---@param image table the loaded snacks.image module
function M.setup(image)
    contain_images(image)
    reshow_images(image)
    border_images(image)
    zoom_images(image)
end

return M
