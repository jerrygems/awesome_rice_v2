local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")
local beautiful = require("beautiful")
local config = require("confs.config").vars


local function notif(n)
    local close_btn = wibox.widget {
        widget = wibox.widget.textbox,
        markup = "close"
    }
    local function textBox(txt, txtcolor, fnt, wrp)
        local box = wibox.widget {
            markup = "<span color='" .. txtcolor .. "' font='" .. fnt .. "'>" .. txt .. "</span>",
            widget = wibox.widget.textbox,
            width = 400
        }
        return box
    end
    local container = wibox.widget {
        {
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
                                textBox(n.title, config.notifs.title_clr, config.notifs.title_fnt), 0, 0, 5, 0), "exact", 0, 40),
                            wibox.container.margin(textBox("<b>" .. n.message .. "</b>", config.notifs.message_clr,
                                config.notifs.message_fnt), 0, 0, 0, 0),

                            layout = wibox.layout.fixed.vertical
                        },
                        widget = wibox.container.margin,
                        width = 400,
                        margins = { left = 10, right = 10 }
                    },
                    widget = wibox.container.constraint,
                    width = config.notifs.max_width,
                }, -- for title and message
                layout = wibox.layout.align.horizontal
            },
            -- {
            --     {
            --         close_btn,
            --         widget = wibox.container.background,
            --         bg = "#ffffff00",
            --     },

            --     layout = wibox.layout.align.horizontal
            -- },
            layout = wibox.layout.align.vertical
        },
        {
            {
                -- notification = n,
                -- base_layout = wibox.widget {
                --     spacing = 3,
                --     spacing_widget = wibox.widget {
                --         orientation = "vertical",
                --         widget = wibox.widget.separator
                --     },
                --     layout = wibox.layout.flex.horizontal
                -- },
                -- widget_template = {
                --     {
                --         {
                --             {
                --                 id     = "text_role",
                --                 text   = "close",
                --                 widget = wibox.widget.textbox
                --             },
                --             widget = wibox.container.place
                --         },
                --         shape              = gears.shape.rounded_rect,
                --         shape_border_width = 2,
                --         shape_border_color = beautiful.bg_normal,
                --         forced_height      = 30,
                --         widget             = wibox.container.background,
                --     },
                --     margins = 4,
                --     widget  = wibox.container.margin,
                -- },
                -- style = {

                -- },
                widget = naughty.list.actions
            },
            widget = wibox.container.background,
            bg = "#00ffff22",
            forced_height = 0, --40,
        },                     -- for actions
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
