local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local topBox = require("popups.musicParts.topBox")
local naughty = require("naughty")


local function musicBox(s, bg, w, h)
    -- naughty.notification({ text = tostring(w) })
    local music = wibox.widget {
        wibox.container.place(topBox.topBox(), "center", "top"),
        widget = wibox.container.margin,
        margins = { top = 6, bottom = 6, left = 10, right = 10 }

    }
    local box = wibox.widget {
        music,
        widget = wibox.container.background,
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 10)
        end,
        bg = bg,
        forced_width = w * 0.8,
        forced_height = h,
    }

    return box
end
return { musicBox = musicBox }
