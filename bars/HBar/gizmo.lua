local gears = require("gears")
local wibox = require("wibox")
local vicious = require("vicious")
local config = require("confs.config").vars

local function gizmoBar(s, icon, textbox, box_width)
    local texty = wibox.widget {
        markup = "<span color='"..config.gizmo_ic_fnt_clr.."'><b>" .. icon .. " </b></span><span color='"..config.gizmo_txt_fnt_clr.."'><small>" .. textbox.text .. "</small></span> ",
        font = config.gizmo_fnt,
        align = 'left',
        valign = 'center',
        widget = wibox.widget.textbox,
    }
    local gizmoBox = wibox.widget {
        {
            texty,
            widget = wibox.container.margin,
            margins = { top = 0, bottom = 0, left = 5, right = 0 }
        },
        widget = wibox.container.margin,
        margins = { top = 2, bottom = 2, left = 1, right = 1 },
        forced_width = box_width
    }
    textbox:connect_signal("widget::redraw_needed", function()
        texty.markup = "<span color='"..config.gizmo_ic_fnt_clr.."'><b>" ..
            icon .. " </b></span><span color='"..config.gizmo_txt_fnt_clr.."'><small>" .. textbox.text .. "</small></span> "
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
        "󰛀 ${wlp61s0 down_mb} Mb/s   󰛃 ${wlp61s0 up_mb} Mb/s", -- wlp61s0 or wlan0 or anyother
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
                bg = config.gizmo_bg,
                shape = function(cr, width, height)
                    gears.shape.rounded_rect(cr, width, height, config.gizmo_radius)
                end,
            },
            widget = wibox.container.margin,
            margins = config.gizmo_mgs,
        },
        layout = wibox.layout.fixed.horizontal,
        widget = wibox.container.background,
    }
    return cont
end

return { gizmoZ = gizmoZ }
