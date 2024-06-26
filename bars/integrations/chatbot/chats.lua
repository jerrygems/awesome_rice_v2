local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")

local function chats()
    local img = gears.color.recolor_image("/home/spidey/.config/awesome/icons/chatbot.svg", "#ffffff")

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
        bg = "#000000ff",
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 10)
        end
    }

    local chatter = wibox.widget {
        box,
        widget = wibox.container.margin,
        margins = 3

    }
    box:buttons(
        awful.button({}, 1, function()
            -- Add your command here
            awful.spawn.easy_async_with_shell("python ~/.config/awesome/AI_integration/GAN/ELL_GUI/app1.py", function()
                -- naughty.notification({ text = "Button clicked!" })
                return nil
            end)
        end)
    )

    chatter:connect_signal("mouse::enter", function()
        box.bg = "#00000077"
    end)
    chatter:connect_signal("mouse::leave", function()
        box.bg = "#000000ff"
    end)

    return chatter
end

return { chats = chats }
