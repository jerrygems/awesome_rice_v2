local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")

local function clock(w, h)
    local timeBox = wibox.widget {
        widget = wibox.widget.textbox,
        markup = "<span color='#ff035b'><b>" .. os.date("%H:%M:%S") .. "</b></span>",
        font = "ArchivoBlack 16",
        align = "center"
    }
    local dateBox = wibox.widget {
        widget = wibox.widget.textbox,
        markup = "<span color='#ff035b'><b>" .. os.date("%d/%m/%y") .. "</b></span>",
        font = "ArchivoBlack 16",
        align = "center"
    }
    local separator = wibox.widget {
        color = "#04d9ff",
        widget = wibox.widget.separator
    }
    gears.timer {
        timeout = 0.3, -- Check every second (adjust as needed)
        autostart = true,
        call_now = false,
        callback = function()
            timeBox.markup = "<span color='#ff035b'><b>" .. os.date("%H:%M:%S") .. "</b></span>"
            dateBox.markup = "<span color='#ff035b'><b>" .. os.date("%d/%m/%y") .. "</b></span>"
        end
    }




    local box = wibox.widget {
        {
            wibox.container.margin(timeBox, 0, 0, 30, 0),
            wibox.container.margin(separator, 30, 30, 0, 0),
            wibox.container.margin(dateBox, 0, 0, 0, 30),


            layout = wibox.layout.flex.vertical
        },

        widget = wibox.container.background,
        forced_height = h * 0.28,
        forced_width = w * 0.40,
        bg = "#00000099",
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 10)
        end
    }

    return box
end

return { clock = clock }
