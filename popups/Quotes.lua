local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local wibox = require("wibox")

local function Quotes(w, h, posx, posy, qt, s)
    local screen_geometry = s.geometry

    local pop_width = screen_geometry.width * (w / 100)
    local pop_height = screen_geometry.height * (h / 100)
    local pop_x = screen_geometry.x + pop_width * posx
    local pop_y = screen_geometry.y + pop_height * posy


    local qt = qt
    local box = awful.popup {
        widget = {
            widget = wibox.widget.background,
            bg = "#00000077",
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 10)
            end,
            {
                {
                    {
                        {
                            widget = wibox.widget.textbox,
                            markup = "<span font='KodeMono 14' color='#ff3333'>" .. qt .. "</span>",
                            wrap = "word",
                            fg = "#ffffff",
                            align = 'center'
                        },
                        widget = wibox.container.margin,
                        margins = { left = 40, right = 40, top = 40, bottom = 0 }
                    },
                    {
                        {
                            widget = wibox.widget.textbox,
                            markup = "<span font='KodeMono 12' color='#ff3333'>~ Mr. Robot</span>",
                            wrap = "word",
                            align = 'center',
                        },
                        widget = wibox.widget.background,
                        forced_height = 60,
                    },
                    layout = wibox.layout.fixed.vertical
                },
                widget = wibox.container.constraint,
                strategy = "max",
                width = pop_width,   --600,
                height = pop_height, --600,
            }
        },
        screen = s,
        x = pop_x, --600,
        y = pop_y, --500,
        visible = true,
        ontop = false,
        bg = "#ffffff11",
    }
    return box
end

return {
    Quotes = Quotes
}
