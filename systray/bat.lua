local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local vicious = require("vicious")
local naughty = require("naughty")
local config = require("confs.config").vars

local function bat0(s)
    local status = wibox.widget {
        font = config.systray_bat_fnt,
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
        background_color = config.systray_bat_bg,
        widget = wibox.widget.progressbar
    }
    local notified = false
    vicious.register(batZ, vicious.widgets.bat, function(widget, args)
        local bat_level = tonumber(args[2])
        local bat_status = args[1]
        if bat_status == "+" then
            widget.color = config.systray_bat_on_charge_bar_clr
            status.markup = "<span color='" .. config.systray_bat_on_charge_symbol_clr .. "'><b>󱐋</b></span>"
        else
            status.markup = ""
            if bat_level < 25 then
                status.markup = "<span color='" .. config.systray_bat_txt_clr_when_below_25 .. "'><b>󰂃</b></span>"
                widget.color = config.systray_bat_clr_when_below_25

                if not notified then
                    naughty.notification({
                        title = config.systray_bat_low_battery_title,
                        text = "Jerry connect your charger i'm gonna die soon"
                    })
                    notified = true
                end
            else
                widget.color = config.systray_bat_not_on_charge_bar_clr
            end
        end
        return bat_level
    end, 5, config.systray_bat_name)

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
                                    margins = {
                                        top = 2,
                                        bottom = 2,
                                        left = 2,
                                        right = 2
                                    }
                                },
                                widget = wibox.container.background,
                                bg = config.systray_bat_clr_behind_bar,
                                shape = function(cr, width, height)
                                    gears.shape.rounded_rect(cr, width, height, 4)
                                end
                            },
                            widget = wibox.container.margin,
                            margins = {
                                top = 3,
                                bottom = 3,
                                left = 3,
                                right = 3
                            }
                        },
                        widget = wibox.container.background,
                        bg = config.systray_bat_border_clr,
                        forced_width = 40,
                        shape = function(cr, width, height)
                            gears.shape.rounded_rect(cr, width, height, 4)
                        end
                    },
                    widget = wibox.container.margin,
                    margins = {
                        top = 0,
                        bottom = 0,
                        left = 0,
                        right = 0
                    }
                },
                {
                    {

                        widget = wibox.container.background,
                        bg = config.systray_bat_border_clr,
                        forced_width = 8,
                        shape = function(cr, width, height)
                            gears.shape.rounded_rect(cr, width, height, 2)
                        end
                    },
                    widget = wibox.container.margin,
                    margins = {
                        top = 5,
                        bottom = 5,
                        left = -2,
                        right = 0
                    }
                },
                layout = wibox.layout.fixed.horizontal
            },
            widget = wibox.container.margin,
            margins = {
                top = 5,
                bottom = 5,
                left = 8,
                right = 8
            }

        },
        widget = wibox.container.background,
        bg = "#00000000",
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 8)
        end
    }

    return battery
end

return {
    bat0 = bat0
}
