local wibox = require("wibox")
local gears = require("gears")
local naughty = require("naughty")
local awful = require("awful")


local function createNotif(n)
    require("drawers.comp.notifBox")(n)
end
local function notifDrawer(n)
    awful.popup {
        widget    = {
            {
                {
                    require("drawers.comp.buttonBox")(),
                    createNotif(n),
                    layout = wibox.layout.align.vertical
                },
                widget = wibox.container.background,
                forced_width = 400,
                forced_height = 600,
                bg = "#11111199"
            },
            widget = wibox.container.margin,
        },
        placement = awful.placement.right,
        shape     = gears.shape.rounded_rect,
        -- visible   = #naughty.active > 0,
        visible   = true,
        bg        = "#00000000",
        -- ontop     = true
    }
end


return notifDrawer
