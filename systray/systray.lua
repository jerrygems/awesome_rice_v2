local wibox = require('wibox')
local gears = require('gears')
local sysbat = require("systray.bat")
local syswifi = require("systray.wifi")
local sysble = require("systray.ble")

local function systray(s)
    local tray = wibox.widget {
        {
            {
                {
                    wibox.container.margin(sysble.ble(s), 2, 2, 0, 0),
                    wibox.container.margin(syswifi.wifi(s), 2, 2, 0, 0),
                    wibox.container.margin(sysbat.bat0(s), 2, 2, 0, 0),

                    layout = wibox.layout.fixed.horizontal,
                    widget = wibox.container.background,
                    bg = '#ffffff55',

                },
                widget = wibox.container.margin,
                margins = { top = 0, bottom = 0, left = 10, right = 10 }
            },
            widget = wibox.container.background,
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 15)
            end,
            bg = "#00000099",
        },
        widget = wibox.container.margin,
        margins = { top = 3, bottom = 3, left = 5, right = 5 }
    }
    return tray
end

return { systray = systray }
