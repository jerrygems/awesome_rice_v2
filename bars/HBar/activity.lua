local gears = require("gears")
local wibox = require("wibox")
local naughty = require("naughty")
local awful = require("awful")
local config = require("confs.config").vars

local function activityBar(s)
    local status = "Unknown"
    local box = wibox.widget {
        markup = "<<span color='"..config.actvt_fnt_clr.."' font='"..config.actvt_fnt.."'><b>Hey, I Just got Started</b></span>",
        widget = wibox.widget.textbox
    }
    client.connect_signal("focus", function(c)
        box.markup = "<span color='"..config.actvt_fnt_clr.."' font='"..config.actvt_fnt.."'><b>" .. c.name .. "</b></span>"
    end)
    client.connect_signal("property::name", function(c)
        box.markup = "<span color='"..config.actvt_fnt_clr.."' font='"..config.actvt_fnt.."'><b>" .. c.name .. "</b></span>"
    end)

    local activity = {
        {
            {
                box,
                widget = wibox.container.place,
                align = "center"
            },
            margins = 5,
            widget = wibox.container.margin
        },
        bg = config.actvt_bg,
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 5)
        end,
        widget = wibox.container.background,
        forced_width = 310
    }
    return wibox.container.margin(activity, config.actvt_mg_left, config.actvt_mg_right, config.actvt_mg_top, config.actvt_mg_bottom)
end

return {
    activityBar = activityBar
}
