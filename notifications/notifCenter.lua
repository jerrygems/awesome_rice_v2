local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")
local beautiful = require("beautiful")
local config = require("confs.config").vars



local function notif(n)
    local function textBox(txt, txtcolor, fnt, wrp)
        local box = wibox.widget {
            markup = "<span color='" .. txtcolor .. "' font='" .. fnt .. "'>" .. txt .. "</span>",
            widget = wibox.widget.textbox,
            width = 340
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
            }, -- for icon
            {

                {
                    {
                        wibox.container.constraint(wibox.container.margin(
                            textBox(n.title, config.notifs.title_clr, config.notifs.title_fnt), 0, 0, 5, 0), "exact", 0, 30),
                        wibox.container.margin(textBox("<b>" .. n.message .. "</b>", config.notifs.message_clr,
                            config.notifs.message_fnt), 0, 0, 0, 0),

                        layout = wibox.layout.fixed.vertical
                    },
                    widget = wibox.container.margin,
                    width = 340,
                    margins = { left = 10, right = 10 }
                },
                widget = wibox.container.constraint,
                width = config.notifs.max_width,
            }, -- for title and message
            layout = wibox.layout.align.horizontal
        },
        -- {
        --     -- incase of error check this section
        --     {

        --         widget = naughty.list.actions
        --     },
        --     widget = wibox.container.background,
        --     bg = "#00000000"
        -- }, -- for actions
        layout = wibox.layout.fixed.vertical
    }


    naughty.layout.box {
        notification = n,
        visible = true,
        type = "notification",
        bg = config.notifs.bg_clr,
        -- placement = awful.placement.bottom,
        shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, 10)
        end,
        widget_template = {
            container,
            bg = "#00000000",
            widget = wibox.container.background,
        }
    }
end


naughty.connect_signal("request::display", function(n)
    beautiful.notification_font = config.notifs.font
    beautiful.notification_bg = config.notifs.bg
    beautiful.notification_fg = config.notifs.fg
    notif(n)
end)



return {
    notifCenter = notif,
}
