local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")
local beautiful = require("beautiful")


local function notifCenter(n)
    local function textBox(txt, txtcolor, fnt)
        local box = wibox.widget {
            markup = "<span color='" .. txtcolor .. "' font='" .. fnt .. "'>" .. txt .. "</span>",
            widget = wibox.widget.textbox,

        }
        return box
    end

    local container = wibox.widget {
        {

            {
                {
                    {
                        image = n.image,
                        forced_height = 70,
                        forced_width = 70,
                        widget = wibox.widget.imagebox
                    },
                    widget = wibox.container.background,
                    shape = function(cr, width, height)
                        gears.shape.rounded_rect(cr, width, height, 6)
                    end
                }, -- for icon
                {

                    {
                        textBox(n.title, "#ffffff", "KodeMono 14"),
                        textBox("<b>" .. n.message .. "</b>", "#f00fff", "JetBrainsMono 8"),

                        layout = wibox.layout.align.vertical
                    },
                    widget = wibox.container.margin,
                    margins = { left = 10, right = 10 }
                }, -- for title and message
                layout = wibox.layout.align.horizontal,
            },
            nil,
            -- {}, -- for actions
            layout = wibox.layout.fixed.vertical,
        },
        margins = 10,
        widget = wibox.container.margin,
    }

    naughty.layout.box {
        notification = n,
        type = "notification",
        bg = "#000000",
        border_width = 0,
        placement = awful.placement.centered,
        shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 10) end,
        widget_template = {
            container,
            bg = beautiful.bg,
            widget = wibox.container.background,
        }
    }
end

return notifCenter
