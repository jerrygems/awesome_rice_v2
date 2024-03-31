local wibox = require("wibox")
local gears = require("gears")
local naughty = require("naughty")
local awful = require("awful")



local function notifBox(n)
    local box = {
        naughty.layout.box {
            notification = n,
            type = "notification",
            bg = "#00000099",
            widget_template = {
                {
                    {
                        {
                            {
                                naughty.widget.icon,
                                {
                                    naughty.widget.title,
                                    naughty.widget.message,
                                    spacing = 4,
                                    layout = wibox.layout.fixed.vertical,
                                },
                                fill_space = true,
                                spacing = 10,
                                layout = wibox.layout.fixed.horizontal,
                            },
                            naughty.list.actions,
                            spacing = 10,
                            layout = wibox.layout.fixed.vertical,
                        },
                        margins = 20,
                        bottom = 10,
                        widget = wibox.container.margin,
                    },
                    id = "background_role",
                    widget = naughty.container.background,
                },
                strategy = "max",
                width = 600,
                widget = wibox.container.constraint,
            },
        }
    }
    return box
end

return notifBox
