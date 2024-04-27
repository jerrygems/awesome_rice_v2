local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local wibox = require("wibox")

local function Quotes()
    local qt = [[
        Wake up to reality! Nothing ever goes as planned in this accursed world. The longer you live, the more you realize that the only things that truly exist in this reality are merely pain. suffering and futility. Listen, everywhere you look in this world, wherever there is light, there will always be shadows to be found as well. As long as there is a concept of victors, the vanquished will also exist. The selfish intent of wanting to preserve peace, initiates war. and hatred is born in order to protect love. There are nexuses causal relationships that cannot be separated
    ]]
    local box = awful.popup {
        widget = {
            widget = wibox.widget.background,
            bg = "#00000077",
            -- forced_height = 100,
            -- forced_width = 300,
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
                            markup = "<span font='KodeMono 12' color='#ff3333'>~ The Ghost of Uchiha</span>",
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
                width = 600,
                height = 600,
            }
        },
        x = 600,
        y = 500,
        visible = true,
        ontop = false,
        bg = "#ffffff11",
    }
    return box
end

return {
    Quotes = Quotes
}
