local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")
local function notificationCenter(s)
    local current_notification = naughty.active[1]

    local notifWidget = naughty.list.notifications {
        base_layout = wibox.widget {

            forced_height = 200,
            forced_width  = 400,
            spacing       = 5,
            layout        = wibox.layout.fixed.vertical
        },
        widget_template = {

            {

                {


                    {
                        {
                            {
                                naughty.widget.icon,
                                widget = wibox.container.background,
                                shape = function(cr, width, height)
                                    gears.shape.rounded_rect(cr, width, height, 10)
                                end,
                            },
                            widget = wibox.container.margin,
                            margins = { top = 2, bottom = 2, left = 2, right = 10 }
                        },

                        widget = wibox.container.background,

                    },
                    {
                        {
                            naughty.widget.title,
                            naughty.widget.message,
                            layout = wibox.layout.fixed.vertical
                        },

                        widget = wibox.container.background,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                widget = wibox.container.margin,
                margins = 5,
            },
            widget = wibox.container.background,
            bg = "#6e96f9",
            fg = '#000000',
            forced_height = 60,
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 10)
            end


        },
    }


    local notifbar = awful.popup {
        widget = {
            wibox.container.margin(notifWidget, 5, 5, 5, 5),
            layout = wibox.layout.align.vertical,
        },
        placement = function(popup)
            awful.placement.top(popup, { margins = { top = 20 } }) -- Adjust the top margin value here
        end,
        bg = "#000000ff",
        visible = #naughty.active > 0,
        ontop = true,
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 10)
        end,
        hide_on_right_click = true,

    }

    naughty.connect_signal("property::active", function()
        current_notification = naughty.active[1]
        notifbar.visible = current_notification ~= nil
    end)

    return notifbar
end

-- Use the notificationCenter function in your wibox setup
return notificationCenter
