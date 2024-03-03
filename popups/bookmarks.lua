local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local shortcuts_list = require("confs.bookmarks_list")



local function bookmarks()
    local box = wibox.widget {
        widget = wibox.widget.textbox,
        text = "Great Expectations",
        font = "JetBrainsMono 30",
    }


    local popup = awful.popup {
        widget = {
            wibox.container.place(box, 'center', 'center'),
            widget = wibox.container.background,
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 10)
            end,
            bg = "#00000077",
            forced_width = 1000,
            forced_height = 600,
        },
        placement = awful.placement.centered,
        visible = true,
        ontop = false,
        bg = "#00000000",
        -- shape = gears.shape.rounded_rect,
        -- border_width = 2,
        -- border_color = "#000000",
    }
    return popup
end

return { bookmarks = bookmarks }
