local wibox = require("wibox")
local gears = require("gears")
local naughty = require("naughty")
local awful = require("awful")



local function switches(s)
    local pop = awful.popup {
        widget    = {
            {
                {
                    require("drawers.comp.buttonBox")(s),
                    layout = wibox.layout.align.vertical
                },
                widget = wibox.container.background,
                forced_width = 400,
                forced_height = 300,
                bg = "#11111199"
            },
            widget = wibox.container.margin,
        },
        placement = function(c)
            awful.placement.top(c, { margins = { top = 80 } })
        end,
        spacing   = 100,
        shape     = gears.shape.rounded_rect,
        visible   = false,
        bg        = "#00000000",
        ontop     = true
    }

    
    return pop
end


return switches
