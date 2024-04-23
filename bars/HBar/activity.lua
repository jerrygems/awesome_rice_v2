local gears = require("gears")
local wibox = require("wibox")
local naughty = require("naughty")
local awful = require("awful")

local function activityBar(s)
    local status = "Unknown"
    local box = wibox.widget {
        markup = "<<span color='#ff035b' font='KodeMono 10'><b>Just got restart</b></span>",
        font = "KodeMono 12",
        widget = wibox.widget.textbox
    }
    client.connect_signal("focus", function(c)
        box.markup = "<span color='#ff035b' font='KodeMono 10'><b>" .. c.name .. "</b></span>"
    end)
    client.connect_signal("property::name", function(c)
        box.markup = "<span color='#ff035b' font='KodeMono 10'><b>" .. c.name .. "</b></span>"
    end)

    local activity = {
        {
            {
                box,
                widget = wibox.container.place,
                align = "center"
            },
            margins = 5,
            widget = wibox.container.margin
        },
        bg = "#00000099",
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 5)
        end,
        widget = wibox.container.background,
        forced_width = 310
    }
    return wibox.container.margin(activity, 7, 7, 5, 5)
end

return { activityBar = activityBar }
