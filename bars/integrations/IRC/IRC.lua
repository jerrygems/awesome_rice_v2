local wibox = require("wibox")
local gears = require("gears")

local function IRC()
    local img = gears.color.recolor_image("/home/spidey/.config/awesome/icons/IRC.svg", "#ffffff")

    local box = wibox.widget {
        {
            {
                image = img,
                widget = wibox.widget.imagebox,
            },
            widget = wibox.container.margin,
            margins = { top = 15, bottom = 15, left = 5, right = 5 },
        },
        widget = wibox.container.background,
        bg = "#000000ff",
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 10)
        end
    }

    local IRCBOX = wibox.widget {
        box,
        widget = wibox.container.margin,
        margins = 3

    }

    IRCBOX:connect_signal("mouse::enter", function()
        box.bg = "#00000077"
    end)
    IRCBOX:connect_signal("mouse::leave", function()
        box.bg = "#000000ff"
    end)

    return IRCBOX
end

return { IRC = IRC }
