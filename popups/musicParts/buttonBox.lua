local wibox = require("wibox")
local gears = require("gears")


local reverse10 = gears.color.recolor_image("/home/spidey/.config/awesome/icons/10SecRev.svg", "#ffffff")
local play = gears.color.recolor_image("/home/spidey/.config/awesome/icons/play.svg", "#ffffff")
local pause = gears.color.recolor_image("/home/spidey/.config/awesome/icons/pause.svg", "#ffffff")
local forward10 = gears.color.recolor_image("/home/spidey/.config/awesome/icons/10SecForward.svg", "#ffffff")
local repeatbtn = gears.color.recolor_image("/home/spidey/.config/awesome/icons/repeat.svg", "#ffffff")
local next = gears.color.recolor_image("/home/spidey/.config/awesome/icons/next-btn.svg", "#ffffff")
local prev = gears.color.recolor_image("/home/spidey/.config/awesome/icons/prev-btn.svg", "#ffffff")


local function buttonBox()
    local btnBox = wibox.widget {
        {
            { -- 10 sec back
                {

                    {

                        image = reverse10,
                        widget = wibox.widget.imagebox

                    },
                    widget = wibox.container.background,
                    bg = "#ffff00",
                },
                widget = wibox.container.margin,
                margins = { top = 13, bottom = 13, left = 13, right = 13 }
            },
            { -- prev
                {

                    {

                        image = prev,
                        widget = wibox.widget.imagebox

                    },
                    widget = wibox.container.background,
                    bg = "#ffff00",
                },
                widget = wibox.container.margin,
                margins = { top = 13, bottom = 13, left = 13, right = 13 }
            },
            { -- play
                {

                    {

                        image = play,
                        widget = wibox.widget.imagebox

                    },
                    widget = wibox.container.background,
                    bg = "#ffff00",
                },
                widget = wibox.container.margin,
                margins = { top = 13, bottom = 13, left = 13, right = 13 }
            },
            {
                {

                    {

                        image = next,
                        widget = wibox.widget.imagebox

                    },
                    widget = wibox.container.background,
                    bg = "#ffff00",
                },
                widget = wibox.container.margin,
                margins = { top = 13, bottom = 13, left = 13, right = 13 }
            },
            { -- 10 sec forward
                {

                    {

                        image = forward10,
                        widget = wibox.widget.imagebox 

                    },
                    widget = wibox.container.background,
                    bg = "#ffff00",
                },
                widget = wibox.container.margin,
                margins = { top = 13, bottom = 13, left = 13, right = 13 }
            },
            { -- repeat
                {

                    {

                        image = repeatbtn,
                        widget = wibox.widget.imagebox

                    },
                    widget = wibox.container.background,
                    bg = "#ffff00",
                },
                widget = wibox.container.margin,
                margins = { top = 13, bottom = 13, left = 13, right = 13 }
            },
            layout = wibox.layout.fixed.horizontal,
        },
        widget = wibox.container.background,
        bg = "#00000000"
    }
    return btnBox
end


return { buttonBox = buttonBox }
