local gears = require("gears")
local wibox = require("wibox")
local naughty = require("naughty")
local awful = require("awful")
local config = require("confs.config").vars

local function activityBar(s)
    local status = "Unknown"
    local box = wibox.widget {
        markup = "<span color='" .. config.activity.fg .. "' font='" .. config.activity.font .. "'><b>Hey, I Just got Started</b></span>",
        widget = wibox.widget.textbox
    }
    client.connect_signal("focus", function(c)
        box.markup = "<span color='" ..
        config.activity.fg .. "' font='" .. config.activity.font .. "'><b>" .. c.name .. "</b></span>"
    end)
    client.connect_signal("property::name", function(c)
        box.markup = "<span color='" ..
        config.activity.fg .. "' font='" .. config.activity.font .. "'><b>" .. c.name .. "</b></span>"
    end)

    local activity = {
        {
            {
                box,
                widget = wibox.container.place,
                align = config.activity.align
            },
            margins = config.activity.txtbox_mg,
            widget = wibox.container.margin
        },
        bg = config.activity.bg,
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, config.activity.radius)
        end,
        widget = wibox.container.background,
        forced_width = config.activity.width
    }
    return wibox.container.margin(activity, config.activity.mg.left, config.activity.mg.right, config.activity.mg.top,
        config.activity.mg.bottom)
end

return {
    activityBar = activityBar
}
