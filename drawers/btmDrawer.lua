local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local shutDrawer = require("drawers.shutDrawer.shutDrawer")

local function btmDrawer()
    local draw = wibox.widget {

        {
            {
                -- shutDrawer.shutDrawer(),
                widget = wibox.container.background,
                bg = "#0000ff",
                shape = function(cr, width, height)
                    gears.shape.rounded_rect(cr, width, height, 10)
                end,
                forced_width = 650,
                forced_height = 50
            },
            widget = wibox.container.place,
            align = 'center',
        },
        widget = wibox.container.margin,
        margins = { bottom = 5, top = 3 }
        -- forced_height = 60,
    }

    return draw
end

return btmDrawer
