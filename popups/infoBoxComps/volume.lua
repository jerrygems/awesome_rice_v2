local wibox = require("wibox")
local gears = require("gears")
local naughty = require("naughty")
local awful = require("awful")

local function volume(s)
    local volProgress = wibox.widget {
        max_value        = 100,
        value            = 30,
        color            = "#ff035b",
        background_color = "#ffffff44",
        widget           = wibox.widget.progressbar,
        shape            = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 18)
        end,
    }
    local vol = wibox.widget {
        max_value        = 100,
        -- value        = 30,
        -- color            = "#ff0000",
        handle_color     = "#00000000",
        value            = 70,
        minimum          = 10,
        maximum          = 100,
        handle_width     = 0,
        -- handle_shape     = function(cr, width, height)
        --     gears.shape.hexagon(cr, 0, height)
        -- end,
        bar_border_width = 1,
        bar_color        = "#ff035b00",
        bar_shape        = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 18)
        end,
        widget           = wibox.widget.slider,
    }
    local volBox = wibox.widget {
        {
            {
                volProgress,
                vol,
                {
                    {
                        widget = wibox.widget.textbox,
                        markup = "<span color='#04d9ff'><b>󰕾</b></span>",
                        font = "JetBrainsMono 14",
                        align = "center",
                        valign = "bottom",
                    },
                    widget = wibox.container.rotate,
                    direction = "west"
                },
                widget = wibox.layout.stack,
            },
            direction = "east",
            layout    = wibox.container.rotate,
        },
        widget = wibox.container.margin,
        margins = { top = 20, bottom = 20, left = 30, right = 0 },
    }
    local prevvol = vol.value
    gears.timer {
        timeout = 0.1, -- Check every second (adjust as needed)
        autostart = true,
        call_now = false,
        callback = function()
            if prevvol ~= vol.value then
                awful.spawn.easy_async("pulsemixer --set-volume " .. vol.value .. "",function()
                    volProgress.value = vol.value
                end)
            end
        end
    }


    local temperature = wibox.widget {
        max_value        = 100,
        value            = 30,
        color            = "#04d9ff",
        background_color = "#ffffff44",
        widget           = wibox.widget.progressbar,
        shape            = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 18)
        end,
    }
    local tempBox = wibox.widget {
        {
            {
                temperature,
                {
                    {
                        widget = wibox.widget.textbox,
                        markup = "<span color='#ff035b'><b>󰔄</b></span>",
                        font = "JetBrainsMono 14",
                        align = "center",
                        valign = "bottom",
                    },
                    widget = wibox.container.rotate,
                    direction = "west"
                },
                layout = wibox.layout.stack
            },
            direction = "east",
            layout    = wibox.container.rotate,
        },
        widget = wibox.container.margin,
        margins = { top = 20, bottom = 20, left = 15, right = 15 },
    }
    -- sensors | grep 'Composite' | awk '{print substr($2,2,length($2-3))}'
    local prevtemp = temperature.val
    gears.timer {
        timeout = 1,
        autostart = true,
        call_now = false,
        callback = function()
            if prevtemp ~= temperature.value then
                awful.spawn.easy_async_with_shell("sensors | grep 'Composite' | awk '{print substr($2,2,length($2-3))}'",
                    function(arg)
                        temperature.value = tonumber(arg)
                    end)
            end
        end
    }
    --
    --
    --

    local brightProgress = wibox.widget {
        max_value        = 100,
        value            = 30,
        color            = "#ff035b",
        background_color = "#ffffff44",
        widget           = wibox.widget.progressbar,
        shape            = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 18)
        end,
    }
    local bright = wibox.widget {
        max_value        = 100,
        -- color         = "#ff0000",
        handle_color     = "#00000000",
        value            = 70,
        minimum          = 10,
        maximum          = 100,
        handle_width     = 0,
        -- handle_shape     = function(cr, width, height)
        --     gears.shape.hexagon(cr, 0, height)
        -- end,
        bar_border_width = 1,
        bar_color        = "#ff035b00",
        bar_shape        = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 18)
        end,
        widget           = wibox.widget.slider,
    }
    local brightBox = wibox.widget {
        {
            {
                brightProgress,
                bright,
                {
                    {
                        widget = wibox.widget.textbox,
                        markup = "<span color='#04d9ff'><b>󰃟</b></span>",
                        font = "JetBrainsMono 14",
                        align = "center",
                        valign = "bottom",
                    },
                    widget = wibox.container.rotate,
                    direction = "west"
                },
                widget = wibox.layout.stack,
            },
            direction = "east",
            layout    = wibox.container.rotate,
        },
        widget = wibox.container.margin,
        margins = { top = 20, bottom = 20, left = 0, right = 30 },
    }
    local prevbright = bright.value
    gears.timer {
        timeout = 0.1, -- Check every second (adjust as needed)
        autostart = true,
        call_now = false,
        callback = function()
            if prevbright ~= bright.value then
                awful.spawn.easy_async("brightnessctl s " .. bright.value .. "%",function()
                    brightProgress.value = bright.value
                end)
            end
        end
    }


    local box = wibox.widget {
        {
            volBox,
            tempBox,
            brightBox,


            layout = wibox.layout.flex.horizontal
        },

        widget = wibox.container.background,
        forced_height = 150,
        forced_width = 150,
        bg = "#00000099",
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 10)
        end
    }

    return box
end

return { volume = volume }
