local gears = require("gears")
local wibox = require("wibox")
local vicious = require("vicious")

local function gizmoBar(s, icon, textbox, box_width)
    local texty = wibox.widget {
        markup = "<b>" .. icon .. " </b><small>" .. textbox.text .. "</small> ",
        font = "JetBrainsMono 13",
        color = "#000000",
        align = 'left',
        valign = 'center',
        widget = wibox.widget.textbox,
    }
    local gizmoBox = wibox.widget {
        {
            {
                texty,
                widget = wibox.container.margin,
                margins = { top = 0, bottom = 0, left = 5, right = 0 }
            },
            widget = wibox.container.background,
            bg = "#0072ff00",
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 5)
            end
        },
        widget = wibox.container.margin,
        margins = { top = 2, bottom = 2, left = 1, right = 1 },
        forced_width = box_width
    }
    textbox:connect_signal("widget::redraw_needed", function()
        texty.markup = "<b>" .. icon .. " </b><small>" .. textbox.text .. "</small> "
    end)
    return gizmoBox
end

local function gizmoZ(s)
    local cpuwidget = wibox.widget.textbox()
    vicious.register(cpuwidget, vicious.widgets.cpu, "$1% ", 1)

    local memwidget = wibox.widget.textbox()
    vicious.register(memwidget, vicious.widgets.mem, "$1% ", 1)

    local netdown = wibox.widget.textbox()
    vicious.register(netdown, vicious.widgets.net,
        "󰛀 ${wlan0 down_mb} Mb/s\t󰛃 ${wlan0 up_mb} Mb/s",
        2)


    local cont = wibox.widget {
        {
            {
                {
                    wibox.container.margin(gizmoBar(s, " ", cpuwidget, 80), 15, 0, 0, 0),
                    gizmoBar(s, " ", memwidget, 100),
                    gizmoBar(s, "", netdown, 200),
                    layout = wibox.layout.fixed.horizontal,
                },
                widget = wibox.widget.background,
                bg = "#00000055",
                shape = function(cr, width, height)
                    gears.shape.rounded_rect(cr, width, height, 15)
                end,
            },
            widget = wibox.container.margin,
            margins = { top = 3, bottom = 3, left = 5, right = 5 },
        },
        layout = wibox.layout.fixed.horizontal,
        widget = wibox.container.background,
    }
    return cont
end

return { gizmoZ = gizmoZ }
