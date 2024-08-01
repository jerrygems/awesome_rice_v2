local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local buttonBox = require("popups.musicParts.buttonBox")
local bottomBox = require("popups.musicParts.bottomBox")

local title = "Unknown"
local artist = "Unknown"

local titleBox = wibox.widget {
    widget = wibox.widget.textbox,
    markup = "<span color='#ffffff'><b>" .. artist .. "</b></span>",
    font = "JetBrainsMono 12",
}
local artistBox = wibox.widget {
    widget = wibox.widget.textbox,
    markup = "<span color='#ffffff'><b>" .. artist .. "</b></span>",
    font = "JetBrainsMono 10",
}

gears.timer {
    timeout = 1,
    autostart = true,
    call_now = true,
    callback = function()
        awful.spawn.easy_async_with_shell("playerctl metadata --format '{{ title }}'",
            function(out)
                titleBox.markup = "<span color='#ff035bff'><b>" .. out .. "</b></span>"
            end
        )

        awful.spawn.easy_async_with_shell("playerctl metadata --format '{{ artist }}'",
            function(out)
                artistBox.markup = "<span color='#ff035bff'><b>" .. out .. "</b></span>"
            end
        )
    end
}

local function topBox()
    local box = wibox.widget {
        { -- buttons and information of media
            {
                {
                    {
                        {
                            {
                                titleBox,
                                widget = wibox.container.margin,
                                margins = { top = 8, bottom = 0, left = 25, right = 25 }
                            },
                            widget = wibox.container.background,
                            bg = "#00000000",
                            forced_height = 30,
                        },
                        {
                            {
                                {
                                    {
                                        artistBox,
                                        widget = wibox.container.background,
                                        forced_height = 15
                                    },
                                    widget = wibox.container.margin,
                                    margins = { top = 5, bottom = 0, left = 25, right = 25 }
                                },
                                {
                                    bottomBox.bottomBox(),
                                    widget = wibox.container.margin,
                                    margins = { top = 0, bottom = 0, left = 25, right = 25 }
                                },
                                layout = wibox.layout.fixed.vertical
                            },
                            widget = wibox.container.background,
                            forced_height = 100,
                            bg = "#00000000",
                        },

                        {
                            {
                                {
                                    buttonBox.buttonBox(),
                                    widget = wibox.container.margin,
                                    margins = { top = 5, bottom = 5, left = 20, right = 20 }
                                },
                                widget = wibox.container.background,
                                bg = "#00000055",
                                shape = function(cr, width, height)
                                    gears.shape.rounded_rect(cr, width, height, 10)
                                end,
                            },
                            widget = wibox.container.place,

                        },
                        layout = wibox.layout.align.vertical,

                    },
                    widget = wibox.container.background,
                    bg = "#00000000",
                },
                widget = wibox.container.margin,
                margins = { top = 10, bottom = 10, left = 10, right = 10 }
            },
            layout = wibox.layout.align.horizontal,
        },
        widget = wibox.container.background,
        bg = "#00000000",
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 10)
        end,


    }

    return box
end
return { topBox = topBox }
