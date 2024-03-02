local wibox = require("wibox")
local gears = require("gears")
local naughty = require("naughty")

local function bottomBox()
    local btmBox = wibox.widget {
        {
            widget = wibox.widget.textbox,
            text = "lyrics ihin this box"
        },
        widget = wibox.container.background,
        bg = "#00000099",
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 10)
        end,
        forced_height = 240,
        forced_width = 560,
    }
    return btmBox
end

return { bottomBox = bottomBox }
