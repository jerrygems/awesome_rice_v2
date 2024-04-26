local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")
local beautiful = require("beautiful")
local config = require("confs.config").vars

local function notifCenter(n)

    local function textBox(txt, txtcolor, fnt, wrp)
        local box = wibox.widget {
            markup = "<span color='" .. txtcolor .. "' font='" .. fnt .. "'>" .. txt .. "</span>",
            widget = wibox.widget.textbox

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
                    wibox.container.constraint(wibox.container.margin(
                        textBox(n.title, config.notif_title_clr, config.notif_title_fnt), 0, 0, 5, 0), "exact", 0, 30),
                    wibox.container.margin(textBox("<b>" .. n.message .. "</b>", config.notif_message_clr,
                        config.notif_message_fnt), 0, 0, 0, 0),

                    layout = wibox.layout.fixed.vertical
                },
                widget = wibox.container.margin,
                forced_width = config.notif_width,
                margins = {
                    left = 10,
                    right = 10
                }
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
        type = "notification",
        bg = config.notif_bg_clr,
        -- placement = awful.placement.bottom,
        shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, 10)
        end,
        widget_template = {
            container,
            bg = "#00000000",
            widget = wibox.container.background
        }
    }

end

return notifCenter
