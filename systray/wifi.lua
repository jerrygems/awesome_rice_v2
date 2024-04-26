local gears = require("gears")
local wibox = require("wibox")
local vicious = require("vicious")
local naughty = require("naughty")
local config = require("confs.config").vars

local function wifi()
    local function arcGen(color, val, m_val, thick, angle, top)
        local arc = wibox.widget {
            {
                value = val,
                max_value = m_val,
                thickness = thick,
                start_angle = angle * math.pi / 180,
                -- end_angle = 0 * math.pi / 180,
                rounded_edge = true,
                bg = "#00000000",
                colors = {color},
                widget = wibox.container.arcchart
            },
            widget = wibox.container.margin,
            margins = {
                top = top,
                bottom = 0,
                left = 0,
                right = 0
            }

        }
        return arc
    end

    local arc2 = arcGen(config.systray_wifi_df_clr, 1, 2, 2.5, 180, -8)
    local arc1 = arcGen(config.systray_wifi_df_clr, 1, 2, 2.5, 180, 0)
    local dot = wibox.widget {
        {
            bg = config.systray_wifi_df_clr,
            shape = gears.shape.circle,
            widget = wibox.container.background
        },
        widget = wibox.container.margin,
        margins = config.systray_wifi_margins
    }

    local function icon()
        local box = wibox.widget {
            arc2,
            arc1,
            dot,
            layout = wibox.layout.stack
        }
        vicious.register(box, vicious.widgets.wifi, function(widget, args)
            local signal = args["{sign}"]

            if signal >= -30 and signal < 0 then -- very strong
                arc2.widget.colors = {config.systray_arc2_clr_c1}
                arc1.widget.colors = {config.systray_arc1_clr_c1}
                dot.widget.bg = config.systray_dot_clr_c1
            elseif signal >= -60 and signal < -30 then -- strong
                arc2.widget.colors = {config.systray_arc2_clr_c2}
                arc1.widget.colors = {config.systray_arc1_clr_c2}
                dot.widget.bg = config.systray_dot_clr_c2
            elseif signal >= -70 and signal < -60 then -- weak
                arc2.widget.colors = {config.systray_arc2_clr_c3}
                arc1.widget.colors = {config.systray_arc1_clr_c3}
                dot.widget.bg = config.systray_dot_clr_c3
            elseif signal > -100 and signal < -70 then -- very weak
                arc2.widget.colors = {config.systray_arc2_clr_c4}
                arc1.widget.colors = {config.systray_arc1_clr_c4}
                dot.widget.bg = config.systray_dot_clr_c4
            else
                arc2.widget.colors = {config.systray_arc2_clr_c5}
                arc1.widget.colors = {config.systray_arc1_clr_c5}
                dot.widget.bg = config.systray_dot_clr_c5
            end
        end, 2, config.systray_wifi_iface_name) -- wlp61s0 or wlan0
        return box
    end

    local wlan0 = wibox.widget {
        {

            {
                icon(),
                align = 'center',
                valign = 'center',
                widget = wibox.container.place

            },
            margins = {
                top = 12,
                bottom = 2,
                left = 10,
                right = 10
            },
            widget = wibox.container.margin
        },
        bg = "#00000000",
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 8)
        end,
        forced_width = 50,
        forced_height = 10,
        widget = wibox.container.background
    }

    return wlan0
end

return {
    wifi = wifi
}
