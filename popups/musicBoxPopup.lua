local wibox = require("wibox")
local gears = require("gears")
local naughty = require("naughty")
local awful = require("awful")



local function musicBoxPopup(s)
    local musicPop = awful.popup {
        widget    = {
            {
                require("popups.musicBox").musicBox(s, "#00000077", 300, 180),
                widget = wibox.container.background,
                forced_width = 400

            },
            layout = wibox.layout.align.vertical
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


    return musicPop
end


return musicBoxPopup
