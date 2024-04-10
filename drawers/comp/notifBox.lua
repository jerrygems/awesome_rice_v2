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
                                {
                                    widget = wibox.widget.imagebox,
                                    image = n.image,
                                    forced_height = 100,
                                    forced_width = 100,
                                },
                                {
                                    {
                                        widget = wibox.widget.textbox,
                                        text = n.title,
                                        font = "JetBrainsMono 15",

                                    },
                                    {
                                        widget = wibox.widget.textbox,
                                        text = n.message,
                                        font = "JetBrainsMono 8",

                                    },

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
            }

        }
    }
    return box
end

return notifBox
