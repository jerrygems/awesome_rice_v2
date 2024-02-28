local gears = require("gears")
local wibox = require("wibox")

local function activityBar(s)
    local activity = {
        {
            {
                markup = '<small><b>in progress</b></small>',
                font = "Lora 10",
                widget = wibox.widget.textbox
            },
            margins = 5,
            widget = wibox.container.margin
        },
        bg = "#000000",
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 5)
        end,
        widget = wibox.container.background,
    }
    return wibox.container.margin(activity, 0, 0, 5, 5)
end

return { activityBar = activityBar }
