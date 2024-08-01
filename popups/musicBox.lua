local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local topBox = require("popups.musicParts.topBox")


local function musicBox(s, bg)
    local music = wibox.widget {
        wibox.container.place(topBox.topBox(), "center", "top"),
        widget = wibox.container.margin,
        margins = { top = 6, bottom = 6, left = 10, right = 10 }

    }
    local box = wibox.widget {
        {
            music,
            widget = wibox.container.background,
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 10)
            end,
            bg = bg,
            forced_width = 300,
            forced_height = 180,
        },
        widget = wibox.widget.background,
        visible = true,
        -- ontop = true,
        bg = "#00000000",

    }

    return box
end
return { musicBox = musicBox }
