local gears = require("gears")
local wibox = require("wibox")
local vicious = require("vicious")
local config = require("confs.config").vars
-- local fetchman = require

local function gizmoBar(s, icon, textbox, box_width)
    local texty = wibox.widget {
        markup = "<span color='" .. config.gizmo.ic_fnt_clr .. "'><b>" .. icon .. " </b></span><span color='" .. config.gizmo.txt_fnt_clr .. "'><small>" .. textbox.text .. "</small></span> ",
        font = config.gizmo.fnt,
        align = 'left',
        valign = 'center',
        widget = wibox.widget.textbox,
    }
    local gizmoBox = wibox.widget {
        {
            texty,
            widget = wibox.container.margin,
            margins = { top = 0, bottom = 0, left = 0, right = 0 }
        },
        widget = wibox.container.margin,
        margins = { top = 2, bottom = 2, left = 0, right = 0 },
        forced_width = box_width
    }
    textbox:connect_signal("widget::redraw_needed", function()
        texty.markup = "<span color='" .. config.gizmo.ic_fnt_clr .. "'><b>" ..
            icon ..
            " </b></span><span color='" .. config.gizmo.txt_fnt_clr .. "'><small>" .. textbox.text .. "</small></span> "
    end)
    return gizmoBox
end

local function gizmoZ(s)
    local cpuwidget = wibox.widget.textbox()
    vicious.register(cpuwidget, vicious.widgets.cpu, "$1% ", 2)

    local memwidget = wibox.widget.textbox()
    vicious.register(memwidget, vicious.widgets.mem, "$1% ", 5)

    local netdown = wibox.widget.textbox()
    vicious.register(netdown, vicious.widgets.net,
        "" ..
        config.gizmo.icons.download_speed ..
        "${" ..
        config.user.wlan_iface ..
        " down_mb} Mb/s   " .. config.gizmo.icons.upload_speed .. "${" .. config.user.wlan_iface .. " up_mb} Mb/s",
        2)


    local cont = wibox.widget {
        {
            {
                {
                    wibox.container.margin(gizmoBar(s, config.gizmo.icons.cpu, cpuwidget, 80), 15, 0, 0, 0),
                    gizmoBar(s, config.gizmo.icons.ram, memwidget, 100),
                    gizmoBar(s, "", netdown, 200),
                    layout = wibox.layout.fixed.horizontal,
                },
                widget = wibox.widget.background,
                bg = config.gizmo.bg,
                shape = function(cr, width, height)
                    gears.shape.rounded_rect(cr, width, height, config.gizmo.radius)
                end,
            },
            widget = wibox.container.margin,
            margins = config.gizmo.margins,
        },
        layout = wibox.layout.fixed.horizontal,
        widget = wibox.container.background,
        visible = config.gizmo.visible
    }
    return cont
end

return { gizmoZ = gizmoZ }
