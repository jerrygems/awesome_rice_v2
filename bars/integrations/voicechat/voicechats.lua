local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")

local function voicechats()
    local img = gears.color.recolor_image("/home/spidey/.config/awesome/icons/wave.svg", "#ffffff")

    local box = wibox.widget {
        {
            {
                image = img,
                widget = wibox.widget.imagebox,
            },
            widget = wibox.container.margin,
            margins = { top = 10, bottom = 10, left = 5, right = 5 },
        },
        widget = wibox.container.background,
        bg = "#000000",
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 10)
        end
    }

    box:buttons(
        awful.button({}, 1, function()
            -- Add your command here
            awful.spawn.easy_async_with_shell("python ~/.config/awesome/AI_integration/GAN/LLMs/app.py", function()
                -- naughty.notification({ text = "Button clicked!" })
                return nil
            end)
        end)
    )

    local voice = wibox.widget {
        box,
        widget = wibox.container.margin,
        margins = 3

    }
    voice:connect_signal("mouse::enter", function()
        box.bg = "#00000077"
    end)
    voice:connect_signal("mouse::leave", function()
        box.bg = "#000000ff"
    end)

    return voice
end

return { voicechats = voicechats }
