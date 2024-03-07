local gears = require("gears")
local wibox = require("wibox")
local naughty = require("naughty")
local awful = require("awful")

local function activityBar(s)
    local status = "Unknown"
    local box = wibox.widget {
        markup = '<b>Just got restart</b>',
        font = "JetBrainsMono 8",
        widget = wibox.widget.textbox
    }
    client.connect_signal("focus", function(c)
        box.markup = '<b>' .. c.name .. '</b>'
    end)
    client.connect_signal("property::name", function(c)
        box.markup = '<b>' .. c.name .. '</b>'
    end)
    -- awful.connect_signal(client.focus,function ()
    --     naughty.notification({text="whatever"})
    -- end)

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
    return wibox.container.margin(activity, 0, 0, 5, 5)
end

return { activityBar = activityBar }
