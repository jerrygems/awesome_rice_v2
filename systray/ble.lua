local gears = require("gears")
local wibox = require("wibox")
local awful = require("awful")
local config = require("confs.config").vars

local function ble(s)
    local icon = gears.color.recolor_image(os.getenv("HOME") .. "/.config/awesome/icons/BLE.svg",
        config.systray_ble_clr_on_disconnected)
    local box = wibox.widget {
        image = icon,
        widget = wibox.widget.imagebox
    }
    local function check_bluetooth()
        awful.spawn.easy_async("bluetoothctl info | grep Connected | awk '{print $2}'", function(output)
            output = output:gsub("^%s*(.-)%s*$", "%1")
            if output == "yes" then
                box.image = gears.color.recolor_image(icon, config.systray.ble.clr_on_connected)
            else
                box.image = gears.color.recolor_image(icon, config.systray.ble.clr_on_disconnected)
            end
        end)
    end
    gears.timer {
        timeout = 5, -- Check every second (adjust as needed)
        autostart = true,
        call_now = true,
        callback = check_bluetooth
    }
    local bluetooth = wibox.widget {
        {
            box,
            widget = wibox.container.margin,
            margins = config.systray.ble.margins
        },
        widget = wibox.container.background,
        bg = "#00000000",
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 8)
        end
    }
    bluetooth:buttons(gears.table.join(awful.button({}, 1, function()
        awful.spawn.easy_async("blueman-manager", function()
            return nil
        end)
    end)))

    return bluetooth
end

return {
    ble = ble
}
