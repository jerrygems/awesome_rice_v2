local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")
local beautiful = require("beautiful")
local function notifDrawer(s)
    local notifbar = naughty.list.notifications {
        base_layout = {
            layout = wibox.layout.flex.vertical
        },
        widget_template = {
            {
                naughty.widget.icon,
                {
                    naughty.widget.title,
                    naughty.widget.message,
                    layout = wibox.layout.align.vertical
                },
                layout = wibox.layout.fixed.horizontal
            },
            margins = 5,
            widget  = wibox.container.margin
        }
    }
    return notifbar
end

return notifDrawer
