local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local vol = require("popups.infoBoxComps.volume")
local sysperf = require("popups.infoBoxComps.sysperf")
local clock = require("popups.infoBoxComps.clock")
local arcbox = require("popups.infoBoxComps.ArcBox")
local musicBox = require("popups.musicBox")
local naughty = require("naughty")

local config = require("confs.config").vars


local function infoBox(w, h, posx, posy, s)
    local screen_geometry = s.geometry

    local pop_width = screen_geometry.width * (w / 100)
    local pop_height = screen_geometry.height * (h / 100)
    local pop_x = screen_geometry.x + pop_width * posx
    local pop_y = screen_geometry.y + pop_height * posy

    local popup = awful.popup {
        widget = {
            {
                {
                    {
                        {
                            vol.volume(pop_width, pop_height),
                            clock.clock(pop_width, pop_height),
                            spacing = w * (100 / 100),
                            layout = wibox.layout.fixed.horizontal,

                        },
                        widget = wibox.container.place,
                        align = 'center',
                    },
                    musicBox.musicBox(s, "#00000099", pop_width, pop_height),
                    {
                        {
                            sysperf.sysperf(pop_width, pop_height),
                            arcbox.ArcBox(pop_width, pop_height),
                            spacing = w * (100 / 100),
                            layout = wibox.layout.fixed.horizontal,

                        },
                        widget = wibox.container.place,
                        align = 'center',
                    },
                    spacing = h * (10 / 100),

                    layout = wibox.layout.flex.vertical
                },
                widget = wibox.container.place,
                align = "center",

            },
            widget = wibox.container.background,
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, config.pop_infobox.radius)
            end,
            bg = config.pop_infobox.container_bg,
            forced_width = pop_width,   -- 400,
            forced_height = pop_height, --600,
        },
        screen = s,
        x = pop_x,
        y = pop_y,
        visible = true,
        ontop = false,
        bg = config.pop_infobox.popup_bg,
        -- shape = gears.shape.rounded_rect,
        border_width = config.pop_infobox.popup_border_width,
        border_color = config.pop_infobox.popup_border_color,
    }
    return popup
end

return { infoBox = infoBox }
