local wibox = require("wibox")
local gears = require("gears")
local naughty = require("naughty")

local function bottomBox(s)
    local WW = s.geometry.width
    local WH = s.geometry.height


    local currentPosition = nil
    local seconds = nil
    local seekbar = wibox.widget {
        widget           = wibox.widget.progressbar,
        shape            = gears.shape.rounded_bar,
        color            = "#ffffff",
        background_color = "#ffffff44",
        value            = 0,
        max_value        = 100,
    }
    gears.timer {
        timeout = 0.5,
        autostart = true,
        call_now = true,
        callback = function()
            currentPosition = tonumber(io.popen("playerctl position", "r"):read("*a"))
            local cp = type(currentPosition) == "number" and tonumber(currentPosition) or 0.0
            seconds = tonumber(io.popen("playerctl metadata | grep ':length' | awk '{print $3}'", "r"):read("*a"))
            local sec = type(seconds) == "number" and tonumber(seconds) or 0.0

            local ratio = ((cp / (sec / 1000000))) * 100
            seekbar:set_value(ratio)
            seekbar:set_max_value(100)
            -- seekbar:set_max_value((math.floor(seconds / 60) / math.floor((seconds) % 60)) * 100)
        end
    }
    local btmBox = wibox.widget {

        {
            seekbar,
            widget = wibox.container.background,
            forced_height = 10
        },
        widget = wibox.container.margin,
        margins = { top = 5, bottom = 5, left = 0, right = 0 }
    }
    return btmBox
end

return { bottomBox = bottomBox }
