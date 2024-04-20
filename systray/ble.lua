local gears = require("gears")
local wibox = require("wibox")
local awful = require("awful")
local naughty = require('naughty')


local function ble(s)
    local icon = gears.color.recolor_image(os.getenv("HOME") .. "/.config/awesome/icons/BLE.svg", "#ffffff")
    local box = wibox.widget {
        image = icon,
        widget = wibox.widget.imagebox
    }
    gears.timer {
        timeout = 5, -- Check every second (adjust as needed)
        autostart = true,
        call_now = true,
        callback = function()
            local command = "bluetoothctl info | grep Connected | awk '{print $2}'"
            local file = io.popen(command)
            local output = file:read("*all")
            file:close()
            output = output:gsub("^%s*(.-)%s*$", "%1")

            if output == "yes" then
                box.image = gears.color.recolor_image(icon, "#00ffff")
            else
                box.image = gears.color.recolor_image(icon, "#ffffff")
            end
        end
    }
    local bluetooth = wibox.widget {
        {
            box,
            widget = wibox.container.margin,
            margins = { top = 5, bottom = 5, left = 15, right = 15 }
        },
        widget = wibox.container.background,
        bg = "#00000000",
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 8)
        end
    }
    bluetooth:buttons(gears.table.join(
        awful.button({}, 1, function()
            awful.spawn.easy_async("blueman-manager", function()
                return nil
            end)
        end)
    ))

    return bluetooth
end

return { ble = ble }
