local gears = require("gears")
local wibox = require("wibox")
local vicious = require("vicious")

local function musicBox()
    local music = wibox.widget {
        {
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 0)
            end
        },
        widget = wibox.container.background,
        bg = "#00000077",
        forced_width = 400,
        height = 250,
    }
    return music
end
return { musicBox = musicBox }
