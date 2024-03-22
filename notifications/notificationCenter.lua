local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")
local function notificationCenter(s)
    local current_notification = naughty.active[1]
    local notifWidget = naughty.list.notifications {
        base_layout = wibox.widget {
            forced_width = 300,
            spacing      = 5,
            layout       = wibox.layout.fixed.vertical
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
            -- fg = '#000000',
            forced_height = 60,
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 10)
            end,


        },

    }


    local notifbar = awful.popup {
        widget = {
            {
                wibox.container.margin(notifWidget, 5, 5, 5, 5),
                layout = wibox.layout.align.vertical,
            },
            widget = wibox.container.constraint,
            height = 140,
        },
        placement = function(popup)
            awful.placement.top(popup, { margins = { top = 20 } }) -- Adjust the top margin value here
        end,
        -- bg = "#ff035bff",
        bg = "#6e96f900",
        fg = "#000000ff",
        visible = #naughty.active > 0,
        ontop = true,
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 10)
        end,
        hide_on_right_click = true,

    }

    naughty.connect_signal("property::active", function()
        notifbar.visible = true ~= nil

        gears.timer.start_new(2.5, function()
            notifbar.visible = false
            return false
        end)
    end)

    return notifbar
end

-- Use the notificationCenter function in your wibox setup
return notificationCenter
