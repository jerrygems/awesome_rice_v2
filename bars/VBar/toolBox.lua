local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local naughty = require("naughty")

local function toolBoxBar(s)
    local HT = s.geometry.height
    local WT = s.geometry.width

    local item1 = wibox.widget {
        widget = wibox.widget.textbox,
        text = "Favorite 1",
    }
    local toolBox = wibox.widget {
        layout = wibox.layout.fixed.vertical,
        {
            widget = wibox.widget.background,
            bg = "#00000055",
            forced_height = HT*(20/100),
            forced_width = 2,
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 5)
            end,
            {
                widget = wibox.widget.textbox,
            }
        },
    }
    return wibox.container.margin(toolBox,5,5,HT*(5/100),0)
end

return { toolBoxBar = toolBoxBar }