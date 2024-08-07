local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local vol = require("popups.infoBoxComps.volume")
local sysperf = require("popups.infoBoxComps.sysperf")
local clock = require("popups.infoBoxComps.clock")
local arcbox = require("popups.infoBoxComps.ArcBox")
local musicBox = require("popups.musicBox")
local naughty = require("naughty")


local function infoBox(s)
    -- naughty.notification({ text = tostring(s.geometry.width) })
    local screen_geometry = s.geometry

    local pop_width = screen_geometry.width*(22/100)
    local pop_height = screen_geometry.height*(53/100)
    local pop_x = screen_geometry.x + pop_width *0.2
    local pop_y = screen_geometry.y + pop_height *0.7

    local popup = awful.popup {
        widget = {
            {
                {
                    {
                        {
                            vol.volume(),
                            clock.clock(),
                            spacing = 30,
                            layout = wibox.layout.fixed.horizontal,

                        },
                        widget = wibox.container.place,
                        align = 'center',
                    },
                    musicBox.musicBox(s),
                    {
                        {
                            sysperf.sysperf(),
                            arcbox.ArcBox(),
                            spacing = 30,
                            layout = wibox.layout.fixed.horizontal,

                        },
                        widget = wibox.container.place,
                        align = 'center',
                    },
                    spacing = 20,

                    layout = wibox.layout.flex.vertical
                },
                widget = wibox.container.place,
                align = "center",

            },
            widget = wibox.container.background,
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 10)
            end,
            bg = "#22222277",
            forced_width = pop_width,   -- 400,
            forced_height = pop_height, --600,
        },
        screen = s,
        x = pop_x,
        y = pop_y,
        visible = true,
        ontop = false,
        bg = "#00000000",
        -- shape = gears.shape.rounded_rect,
        -- border_width = 2,
        -- border_color = "#000000",
    }
    return popup
end

return { infoBox = infoBox }
