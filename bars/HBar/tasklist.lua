local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local naughty = require("naughty")

local function tasklistBar(s)
    local tasklist = awful.widget.tasklist({
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        style = {
            bg = "#00000099",
            fg = '#000000',
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 5)
            end
        },
        layout = {
            spacing = 5,
            layout = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {

                {
                    id = 'icon_role',
                    widget = wibox.widget.imagebox,
                },
                margins = 5,
                widget = wibox.container.margin,
            },
            widget = wibox.container.background,
            forced_height = 30,
            forced_width = 30,
            bg = "#000000",
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 5)
            end,
        },

    })


    local c2 = wibox.widget {
        {

            {
                {
                    {
                        tasklist,
                        widget = wibox.container.constraint,
                        width = 210
                    },
                    widget = wibox.container.background,
                    bg = "#00000055",
                    shape = function(cr, width, height)
                        gears.shape.rounded_rect(cr, width, height, 5)
                    end,
                },
                widget = wibox.container.margin,
                margins = { top = 0, bottom = 0, left = 5, right = 5 }
            },
            widget = wibox.container.place,
            halign = "left"
        },
        widget = wibox.container.background,
        forced_width = 230
    }

    return c2
end
return { tasklistBar = tasklistBar }
