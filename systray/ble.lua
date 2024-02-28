local gears = require("gears")
local wibox = require("wibox")

local function ble(s)
    local icon = os.getenv("HOME") .. "/.config/awesome/icons/BLE.svg"
    local bluetooth = wibox.widget {
        {
            {
                image = icon,
                widget = wibox.widget.imagebox
            },
            widget = wibox.container.margin,
            margins = { top = 5, bottom = 5, left = 15, right = 15 }
        },
        widget = wibox.container.background,
        bg = "#00000000",
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 8)
        end
    }

    return bluetooth
end

return { ble = ble }
