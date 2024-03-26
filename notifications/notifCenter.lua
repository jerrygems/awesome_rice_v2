local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")
local beautiful = require("beautiful")


local function notifCenter(n)
    local function textBox(txt, txtcolor, fnt, wrp)
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
                },
                widget = wibox.container.margin,
                margins = 10
            }

            , -- for icon
            {

                {
                    wibox.container.constraint(wibox.container.margin(textBox(n.title, "#ffffff", "KodeMono 14"), 0, 0, 5, 0), "exact", 0,30),
                    wibox.container.margin(textBox("<b>" .. n.message .. "</b>", "#f00fff", "JetBrainsMono 8"), 0, 0, 0, 0),

                    layout = wibox.layout.fixed.vertical
                },
                widget = wibox.container.margin,
                forced_width = 400,
                margins = { left = 10, right = 10 }
            }, -- for title and message
            layout = wibox.layout.align.horizontal,
        },
        {
            -- incase of error check this section
            {
                {
                    text = 'hell',
                    widget = wibox.widget.textbox,
                },
                widget = naughty.list.actions,
            },
            widget = wibox.container.background,
            bg = "#ff00ff",
        }, -- for actions
        layout = wibox.layout.fixed.vertical,
    }

    naughty.layout.box {
        notification = n,
        type = "notification",
        bg = "#111111",
        placement = awful.placement.centered,
        shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 10) end,
        widget_template = {
            container,
            bg = beautiful.bg,
            widget = wibox.container.background,
        },
    }
end

return notifCenter
