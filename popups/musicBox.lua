local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local getImage = require("scripts.getImage")
local naughty = require("naughty")
local bottomBox = require("popups.musicParts.bottomBox")
local topBox = require("popups.musicParts.topBox")


local function musicBox(s)

    local WW = s.geometry.width
    local WH = s.geometry.height

    local music = wibox.widget {
        wibox.container.place(topBox.topBox(s), "center", "top"),
        widget = wibox.container.margin,
        margins = { top = WH * (0.7 / 100), bottom = WH * (0.7 / 100), left = WW * (0.5 / 100), right = WW * (0.5 / 100) }

    }
    local popup = awful.popup {
        widget = {
            music,
            widget = wibox.container.background,
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 10)
            end,
            bg = "#00000099",
            forced_width = WW * (20 / 100),
            forced_height = WH * (18 / 100),
        },
        placement = awful.placement.centered,
        visible = true,
        ontop = false,
        bg = "#00000000",

    }

    return popup
end
return { musicBox = musicBox }
