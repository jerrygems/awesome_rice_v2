local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local getImage = require("scripts.getImage")
local naughty = require("naughty")





local function musicBox()
    local reverse10 = gears.color.recolor_image("/home/spidey/.config/awesome/icons/10SecRev.svg", "#ffffff")
    local play = gears.color.recolor_image("/home/spidey/.config/awesome/icons/play.svg", "#ffffff")
    local pause = gears.color.recolor_image("/home/spidey/.config/awesome/icons/pause.svg", "#ffffff")
    local forward10 = gears.color.recolor_image("/home/spidey/.config/awesome/icons/10SecForward.svg", "#ffffff")
    local repeatbtn = gears.color.recolor_image("/home/spidey/.config/awesome/icons/repeat.svg", "#ffffff")
    local next = gears.color.recolor_image("/home/spidey/.config/awesome/icons/next-btn.svg", "#ffffff")
    local prev = gears.color.recolor_image("/home/spidey/.config/awesome/icons/prev-btn.svg", "#ffffff")


    -- titleBox
    local title = ""
    local artist = ""

    local titleBox = wibox.widget {
        widget = wibox.widget.textbox,
        markup = "<span color='#ffffff'><b>" .. artist .. "</b></span>",
        font = "JetBrainsMono 15",
    }
    gears.timer {
        timeout = 1,
        autostart = true,
        call_now = true,
        callback = function()
            title = io.popen("playerctl metadata | awk '/:title/{for (i=3; i<=NF; i++) printf \"%s \", $i}'", 'r'):read(
                "*a")
            artist = io.popen("playerctl metadata | awk '/:artist/{for (i=3; i<=NF; i++) printf \"%s \", $i}'", 'r')
                :read(
                    "*a")
            titleBox.markup = "<span color='#ffffff'><b>" .. title .. "</b></span>"
        end
    }

    local buttonBox = wibox.widget {
        {

            { -- 10 sec back
                {
                    image = reverse10,
                    widget = wibox.widget.imagebox
                },
                widget = wibox.container.margin,
                margins = { top = 13, bottom = 13, left = 13, right = 13 }
            },
            { -- prev
                {
                    image = prev,
                    widget = wibox.widget.imagebox
                },
                widget = wibox.container.margin,
                margins = { top = 13, bottom = 13, left = 13, right = 13 }
            },
            { -- play
                {
                    image = play,
                    widget = wibox.widget.imagebox
                },
                widget = wibox.container.margin,
                margins = { top = 13, bottom = 13, left = 13, right = 13 }
            },
            { -- next
                {
                    image = next,
                    widget = wibox.widget.imagebox
                },
                widget = wibox.container.margin,
                margins = { top = 13, bottom = 13, left = 13, right = 13 }
            },
            { -- 10 sec forward
                {
                    image = forward10,
                    widget = wibox.widget.imagebox
                },
                widget = wibox.container.margin,
                margins = { top = 13, bottom = 13, left = 13, right = 13 }
            },
            { -- repeat
                {
                    image = repeatbtn,
                    widget = wibox.widget.imagebox
                },
                widget = wibox.container.margin,
                margins = { top = 16, bottom = 10, left = 13, right = 13 }
            },
            layout = wibox.layout.fixed.horizontal,
        },
        widget = wibox.container.background,
        bg = "#00000000"
    }
    local topBox = wibox.widget {
        {
            { -- album image
                {
                    {
                        image = "",
                        widget = wibox.widget.imagebox,
                    },
                    widget = wibox.container.background,
                    bg = "#6e96f9ff",
                    shape = function(cr, width, height)
                        gears.shape.rounded_rect(cr, width, height, 15)
                    end,
                    forced_width = 150,
                },
                widget = wibox.container.margin,
                margins = { top = 20, bottom = 20, left = 15, right = 15 }

            },
            { -- buttons and information of media
                {
                    {
                        {
                            {
                                titleBox,
                                widget = wibox.container.margin,
                                margins = { top = 10, bottom = 0, left = 25, right = 25 }
                            },
                            widget = wibox.container.background,
                            bg = "#00000000",
                            forced_height = 40,
                        },
                        {
                            {
                                titleBox,
                                widget = wibox.container.margin,
                                margins = { top = 0, bottom = 0, left = 25, right = 25 }
                            },
                            widget = wibox.container.background,
                            forced_height = 30,
                            bg = "#00000000",
                        },
                        buttonBox,
                        layout = wibox.layout.fixed.vertical,
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
        forced_height = 150,
        forced_width = 560,

    }
    local bottomBox = wibox.widget {
        {
            widget = wibox.widget.textbox,
            text = "lyrics ihin this box"
        },
        widget = wibox.container.background,
        bg = "#00000099",
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 10)
        end,
        forced_height = 240,
        forced_width = 560,
    }
    local music = wibox.widget {
        {
            wibox.container.place(topBox, "center", "top"),
            wibox.container.place(bottomBox, "center", "bottom"),
            layout = wibox.layout.align.vertical
        },
        widget = wibox.container.margin,
        margins = { top = 20, bottom = 20, left = 20, right = 20 }

    }
    local popup = awful.popup {
        widget = {
            music,
            widget = wibox.container.background,
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 10)
            end,
            bg = "#000000dd",
            forced_width = 600,
            forced_height = 450,
        },
        placement = awful.placement.centered,
        visible = true,
        ontop = false,
        bg = "#00000000",
        -- shape = gears.shape.rounded_rect,
        -- border_width = 2,
        -- border_color = "#000000",

    }

    local updateMan = gears.timer {
        timeout = 1,
        autostart = true,
        call_now = true,
        callback = function()

        end
    }

    return popup
end
return { musicBox = musicBox }
