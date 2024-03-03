local wibox = require("wibox")
local gears = require("gears")
local buttonBox = require("popups.musicParts.buttonBox")
local bottomBox = require("popups.musicParts.bottomBox")

local title = "Unknown"
local artist = "Unknown"
local img = "Unknown"
local artUrl = "Unknown"

local titleBox = wibox.widget {
    widget = wibox.widget.textbox,
    markup = "<span color='#ffffff'><b>" .. artist .. "</b></span>",
    font = "JetBrainsMono 15",
}
local artistBox = wibox.widget {
    widget = wibox.widget.textbox,
    markup = "<span color='#ffffff'><b>" .. artist .. "</b></span>",
    font = "JetBrainsMono 15",
}
local imageBox = wibox.widget {
    widget = wibox.widget.imagebox,
    image = img,
    resize = true,
}
gears.timer {
    timeout = 1,
    autostart = true,
    call_now = true,
    callback = function()
        title            = io.popen("playerctl metadata | awk '/:title/{for (i=3; i<=NF; i++) printf \"%s \", $i}'",
            'r'):read(
            "*a")
        artist           = io.popen("playerctl metadata | awk '/:artist/{for (i=3; i<=NF; i++) printf \"%s \", $i}'",
                'r')
            :read(
                "*a")
        artUrl           = io.popen("playerctl metadata | awk '/:artUrl/{for (i=3; i<=NF; i++) printf \"%s \", $i}'",
                'r')
            :read(
                "*a")

        -- awful.spawn.easy_async_with_shell("wget " .. artUrl .. " -O /home/spidey/.config/awesome/dust/waste/music")

        titleBox.markup  = "<span color='#ffffff'><b>" .. title .. "</b></span>"
        artistBox.markup = "<span color='#ffffff'><b>" .. artist .. "</b></span>"
        imageBox.image   = "/home/spidey/.config/awesome/dust/waste/music"
    end
}

local function topBox(s)
    local WW = s.geometry.width
    local WH = s.geometry.height
    local box = wibox.widget {
        { -- buttons and information of media
            {
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
                            forced_height = WH * (4 / 100),
                        },
                        {
                            {
                                {
                                    artistBox,
                                    widget = wibox.container.margin,
                                    margins = { top = 0, bottom = 0, left = 25, right = 25 }
                                },
                                {
                                    bottomBox.bottomBox(s),
                                    widget = wibox.container.margin,
                                    margins = { top = 10, bottom = 10, left = 25, right = 25 }
                                },
                                layout = wibox.layout.align.vertical
                            },
                            widget = wibox.container.background,
                            forced_height = WH * (3 / 100),
                            bg = "#00000000",
                        },

                        {
                            {
                                {
                                    buttonBox.buttonBox(s),
                                    widget = wibox.container.margin,
                                    margins = { top = 5, bottom = 5, left = 20, right = 20 }
                                },
                                widget = wibox.container.background,
                                bg = "#000000",
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
                    forced_width = WW * (20 / 100)
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
        forced_height = WH * (18 / 100),
        forced_width = WW * (20 / 100),

    }

    return box
end
return { topBox = topBox }
