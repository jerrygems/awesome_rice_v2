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
            forced_width = 400,
            forced_height = 600,
        },
        x = 120,
        y = 380,
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
