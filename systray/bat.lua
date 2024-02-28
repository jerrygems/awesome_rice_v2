local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local vicious = require("vicious")
local naughty = require("naughty")

local function bat0(s)
    local status = wibox.widget {
        font = "JetBrainsMono 14",
        align = 'center',
        valign = 'center',
        widget = wibox.widget.textbox
    }
    local batZ = wibox.widget {
        -- value = 50
        max_value = 1,
        shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, 2)
        end,
        color = "#ffffff",
        background_color = "#000000",
        widget = wibox.widget.progressbar,
    }
    local notified = false
    vicious.register(batZ, vicious.widgets.bat, function(widget, args)
        local bat_level = tonumber(args[2])
        local bat_status = args[1]
        if bat_status == "+" then
            widget.color = "#999999"
            status.markup = "<span color='#ffffffaa'><b>󱐋</b></span>"
        else
            status.markup = ""
            if bat_level < 25 then
                status.markup = "<span color='#e3242b88'><b>󰂃</b></span>"
                widget.color = "#e3242b"

                if not notified then
                    naughty.notification({
                        title = "Critical Battery Level",
                        text =
                        "Jerry connect your charger i'm gonna die soon"
                    })
                    notified = true
                end
            else
                widget.color = "#ffffff"
            end
        end
        return bat_level
    end, 5, "BAT1")

    local battery = wibox.widget {
        {
            {
                {
                    {
                        {
                            {
                                {
                                    {
                                        batZ,
                                        status,
                                        layout = wibox.layout.stack
                                    },
                                    widget = wibox.container.margin,
                                    margins = { top = 2, bottom = 2, left = 2, right = 2 }
                                },
                                widget = wibox.container.background,
                                bg = "#000000",
                                shape = function(cr, width, height)
                                    gears.shape.rounded_rect(cr, width, height, 4)
                                end,
                            },
                            widget = wibox.container.margin,
                            margins = { top = 3, bottom = 3, left = 3, right = 3 }
                        },
                        widget = wibox.container.background,
                        bg = "#ffffff",
                        forced_width = 40,
                        shape = function(cr, width, height)
                            gears.shape.rounded_rect(cr, width, height, 4)
                        end,
                    },
                    widget = wibox.container.margin,
                    margins = { top = 0, bottom = 0, left = 0, right = 0 }
                },
                {
                    {

                        widget = wibox.container.background,
                        bg = "#ffffff",
                        forced_width = 8,
                        shape = function(cr, width, height)
                            gears.shape.rounded_rect(cr, width, height, 2)
                        end,
                    },
                    widget = wibox.container.margin,
                    margins = { top = 5, bottom = 5, left = -2, right = 0 }
                },
                layout = wibox.layout.fixed.horizontal
            },
            widget = wibox.container.margin,
            margins = { top = 5, bottom = 5, left = 8, right = 8 }

        },
        widget = wibox.container.background,
        bg = "#00000000",
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 8)
        end
    }



    return battery
end

return { bat0 = bat0 }
