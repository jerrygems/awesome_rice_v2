local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local vol = require("popups.infoBoxComps.volume")
local clock = require("popups.infoBoxComps.clock")


local function infoBox(s)
    local box = wibox.widget {
        vol.volume(s),
        widget = wibox.container.background,
    }


    local popup = awful.popup {
        widget = {
            wibox.container.place(clock.clock(), 'center', 'center'),
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

return { infoBox = infoBox }
