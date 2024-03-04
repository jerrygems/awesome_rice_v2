local gears = require("gears")
local wibox = require("wibox")
local naughty = require("naughty")
local awful = require("awful")

local function activityBar(s)
    local status = "Unknown"
    local box = wibox.widget {
        markup = '<small><b>in progress</b></small>',
        font = "Lora 10",
        widget = wibox.widget.textbox
    }

    -- awful.connect_signal(client.focus,function ()
    --     naughty.notification({text="whatever"})
    -- end)



    local activity = {
        {
            box,
            margins = 5,
            widget = wibox.container.margin
        },
        bg = "#00000099",
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 5)
        end,
        widget = wibox.container.background,
    }
    return wibox.container.margin(activity, 0, 0, 5, 5)
end

return { activityBar = activityBar }
