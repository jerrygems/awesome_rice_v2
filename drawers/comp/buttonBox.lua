local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local home_dir = os.getenv("HOME")



local function btngen(name, img)
    local btn = wibox.widget {
        {
            {
                {
                    {
                        widget = wibox.widget.imagebox,
                        image = img,
                    },
                    widget = wibox.container.margin,
                    margins = 15,
                },
                widget = wibox.container.place,
                align = 'center',
                valign = 'center',
            },
            widget = wibox.container.background,
            bg = "#00000099",
            forced_height = 50,
            forced_width = 58,
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 10)
            end

        },
        widget = wibox.container.margin,
        margins = { top = 10, bottom = 8, left = 8, right = 8 }
    }


    return btn
end

local function buttonBox()
    return wibox.widget {
        {
            {
                {
                    -- require("systray.wifi")(),
                    btngen("Bluetooth", home_dir .. "/.config/awesome/icons/blue.svg"),
                    btngen("Bluetooth", home_dir .. "/.config/awesome/icons/vol-full.svg"),
                    btngen("Bluetooth", home_dir .. "/.config/awesome/icons/WiFi.svg"),
                    btngen("Bluetooth", home_dir .. "/.config/awesome/icons/showbars.svg"),
                    layout = wibox.layout.grid,
                    homogeneous = true,
                    orientation = 'vertical',
                    forced_num_cols = 5,
                    forced_num_rows = 3
                },
                widget = wibox.container.place,
                align = 'center',
                valign = 'center',
            },
            widget = wibox.container.background,
            forced_height = 210,
            forced_width = 300,
            bg = "#00000099",
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 10)
            end
        },
        widget = wibox.container.margin,
        margins = { top = 10, bottom = 5, left = 10, right = 10 }
    }
end

return buttonBox
