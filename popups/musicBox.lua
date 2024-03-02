local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local getImage = require("scripts.getImage")
local naughty = require("naughty")
local bottomBox = require("popups.musicParts.bottomBox")
local topBox = require("popups.musicParts.topBox")



local function musicBox()
    -- titleBox


    local music = wibox.widget {
        {
            wibox.container.place(topBox.topBox(), "center", "top"),
            wibox.container.place(bottomBox.bottomBox(), "center", "bottom"),
            layout = wibox.layout.align.vertical
        },
        widget = wibox.container.margin,
        margins = { top = 20, bottom = 20, left = 20, right = 20 }

    }
    local popup = awful.popup {
        widget = {
            music,
            widget = wibox.container.background,
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 10)
            end,
            bg = "#000000dd",
            forced_width = 600,
            forced_height = 450,
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
return { musicBox = musicBox }
