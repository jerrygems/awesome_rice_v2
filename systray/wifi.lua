local naughty = require("gears")
local wibox = require("wibox")
local vicious = require("vicious")
local config = require("confs.config").vars
local lgi = require("lgi")
local Cairo = lgi.cairo

local function wifi_draw(colors)
    local width, height = 50, 50
    local deg = math.pi / 180

    local surface = Cairo.ImageSurface.create(Cairo.Format.ARGB32, width, height)
    local cr = Cairo.Context(surface)

    cr:set_line_width(5)
    cr:set_source_rgb(table.unpack(colors[1] or { 1, 1, 1 }))
    cr:arc(width / 2, height / 2, 24, 220 * deg, -40 * deg)
    cr:stroke()

    cr:set_line_width(5)
    cr:set_source_rgb(table.unpack(colors[2] or { 1, 1, 1 }))
    cr:arc(width / 2, height / 2, 16, 220 * deg, -40 * deg)
    cr:stroke()

    cr:set_line_width(5)
    cr:set_source_rgb(table.unpack(colors[3] or { 1, 1, 1 }))
    cr:arc(width / 2, height / 2, 8, 220 * deg, -40 * deg)
    cr:stroke()

    cr:set_line_width(3)
    cr:set_source_rgb(table.unpack(colors[4] or { 1, 1, 1 }))
    cr:arc(width / 2, height / 2, 3, 0 * deg, 360 * deg)
    cr:fill()

    return surface
end


local function wifi()
    local function get_colors(signal_strength)
        if signal_strength >= -40 and signal_strength < 0 then
            return config.systray.wifi.high
        elseif signal_strength >= -60 and signal_strength < -40 then
            return config.systray.wifi.medium
        elseif signal_strength >= -70 and signal_strength < -60 then
            return config.systray.wifi.weak
        elseif signal_strength >= -90 and signal_strength < -70 then
            return config.systray.wifi.veryweak
        else
            return config.systray.wifi.no_signal
        end
    end

    local icon = wibox.widget {
        image = wifi_draw(get_colors(-60)),
        widget = wibox.widget.imagebox
    }

    local function update_icon(signal_strength)
        local colors = get_colors(signal_strength)
        icon.image = wifi_draw(colors)
    end

    vicious.register(icon, vicious.widgets.wifi, function(widget, args)
        local signal = args["{sign}"]
        update_icon(signal)
        return ""
    end, 5, config.systray_wifi_iface_name)

    local wlan0 = wibox.widget {
        wibox.container.margin(icon, 0, 0, 5, -11),
        align = 'center',
        valign = 'center',
        widget = wibox.container.place
    }

    return wlan0
end

return {
    wifi = wifi
}
