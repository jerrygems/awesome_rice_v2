local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local wibox = require("wibox")

local function Quotes()
    local box = awful.popup {
        widget = {
            widget = wibox.widget.background,
            bg = "#00000077",
            forced_height = 100,
            forced_width = 300,
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 10)
            end,
            {
                widget = wibox.widget.textbox,
                markup = "<span font='KodeMono 24'>Jerrygems</span>",
                wrap = "word",
                fg="#ffffff",
                align = 'center'
            }
        },
        x = 800,
        y = 900,
        visible = true,
        ontop = false,
        bg = "#ffffff11",
    }
    return box
end

return {
    Quotes = Quotes
}
