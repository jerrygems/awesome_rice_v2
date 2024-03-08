local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")

local function volume(s)
    local vol = wibox.widget {
        {
            {
                max_value        = 100,
                value            = 30,
                color            = "#6e96f9",
                background_color = "#6e96f999",
                widget           = wibox.widget.progressbar,
                shape            = function(cr, width, height)
                    gears.shape.rounded_rect(cr, width, height, 18)
                end,
            },
            forced_height = 60,
            forced_width  = 10,
            direction     = "east",
            layout        = wibox.container.rotate,
        },
        widget = wibox.container.margin,
        margins = { top = 20, bottom = 20, left = 20, right = 0 },
    }
    local brightness = wibox.widget {
        {
            {
                max_value        = 100,
                value            = 30,
                color            = "#6e96f9",
                background_color = "#6e96f999",
                widget           = wibox.widget.progressbar,
                shape            = function(cr, width, height)
                    gears.shape.rounded_rect(cr, width, height, 18)
                end,
            },
            forced_height = 60,
            forced_width  = 10,
            direction     = "east",
            layout        = wibox.container.rotate,
        },
        widget = wibox.container.margin,
        margins = { top = 20, bottom = 20, left = 10, right = 10 },
    }
    local mic = wibox.widget {
        {
            {
                max_value        = 100,
                -- value        = 30,
                -- color            = "#ff0000",
                handle_color     = "#ffff00",
                value            = 70,
                minimum          = 0,
                maximum          = 100,
                handle_width     = 10,
                handle_shape     = function(cr, width, height)
                    gears.shape.rounded_rect(cr, width, height, 18)
                end,
                bar_border_width = 1,
                bar_color        = "#6e96f999",
                bar_shape        = function(cr, width, height)
                    gears.shape.rounded_rect(cr, width, height, 18)
                end,
                widget           = wibox.widget.slider,
            },
            direction = "east",
            layout    = wibox.container.rotate,
        },
        widget = wibox.container.margin,
        margins = { top = 20, bottom = 20, left = 0, right = 20 },
    }


    local box = wibox.widget {
        {
            vol,
            brightness,
            mic,


            layout = wibox.layout.flex.horizontal
        },

        widget = wibox.container.background,
        forced_height = 150,
        forced_width = 150,
        bg = "#000000ff",
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 10)
        end
    }

    return box
end

return { volume = volume }
