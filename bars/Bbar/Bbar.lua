local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local gears = require("gears")
local vicious = require("vicious")
local config = require("confs.config").vars

local command = "hostnamectl | awk -F ':' '/Operating System/ {print $2}'"
local file = io.popen(command)
local output0 = file:read("*all")
file:close()

-- wifi info
local info1 = wibox.widget.textbox()
info1.forced_width = 120
info1.align = 'center'
vicious.register(info1, vicious.widgets.wifi, function(widget, args)
    info1.markup = "<span font='" .. config.btm_bar_fnt .. "'> 󰹤 " .. args["{sign}"] .. "</span>"
end, 2, config.systray_wifi_iface_name)

local info5 = wibox.widget.textbox()
info5.forced_width = 120
vicious.register(info5, vicious.widgets.uptime, "<span font='" .. config.btm_bar_fnt .. "'><b> 󱟠 </b>$3 min</span>",
    60)

local info4 = wibox.widget.textbox()
info4.forced_width = 450
vicious.register(info4, vicious.widgets.os,
    "<span font='" .. config.btm_bar_fnt .. "'>  $3@$4<b>  </b>" .. output0 .. "  </span>", 2)

-- mem info
local info2 = wibox.widget.textbox()
info2.forced_width = 120
info2.align = 'center'
vicious.register(info2, vicious.widgets.mem, "<span font='" .. config.btm_bar_fnt .. "'> <b></b> $2MB</span>", 13)

local info3 = wibox.widget.textbox()
info3.forced_width = 120
vicious.register(info3, vicious.widgets.cpufreq, "<span font='" .. config.btm_bar_fnt .. "'> <b></b> $1 </span>", 2,
    config.btm_bar_cpu)

local function Bbar(s)
    local box = wibox.widget {

        widget = wibox.widget.background,
        -- bg = '#ffffff77',
        forced_width = s.geometry.width,
        -- align = 'center',
        {
            {
                widget = wibox.container.place,
                align = 'center',
                {
                    {
                        info1,
                        info5,
                        layout = wibox.layout.align.horizontal
                    },
                    widget = wibox.widget.background
                    -- bg = "#555555"
                }
            },
            {
                widget = wibox.container.place,
                align = 'center',
                {
                    widget = wibox.widget.background,
                    -- bg = "#ffffff77",
                    info4
                }

            },
            {
                widget = wibox.container.place,
                align = 'center',
                {
                    {
                        info2,
                        info3,
                        layout = wibox.layout.align.horizontal
                    },
                    widget = wibox.widget.background
                    -- bg = "#555555"
                }
            },

            layout = wibox.layout.flex.horizontal,
            spacing = 20
        }

    }
    return box
end

return {
    Bbar = Bbar
}
