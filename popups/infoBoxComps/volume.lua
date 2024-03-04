local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")

local function volume(s)
    
    local bar1 = wibox.widget {
        text = "hell",
        widget = wibox.widget.textbox,

    }
    local bar2 = wibox.widget {
        text = "hell",
        widget = wibox.container.background,

    }
    local bar3 = wibox.widget {
        text = "hell",
        widget = wibox.container.background,

    }



    local box = wibox.widget {
        {
            bar1,
            bar2,
            bar3,
            layout = wibox.layout.align.horizontal
        },

        widget = wibox.container.background,
        forced_height = 200,
        forced_width = 200,
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 10)
        end
    }

    return box
end

return { volume = volume }
