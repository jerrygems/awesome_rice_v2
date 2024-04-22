local gears = require("gears")
local wibox = require("wibox")
local awful = require("awful")
local chats = require("bars.integrations.chatbot.chats")
local voicechat = require("bars.integrations.voicechat.voicechats")
local IRC = require("bars.integrations.IRC.IRC")

local function integrations(s)
    local AI_bar = wibox.widget {
        {
            {
                {
                    {
                        chats.chats(),
                        voicechat.voicechats(),
                        IRC.IRC(),
                        layout = wibox.layout.fixed.vertical,
                    },
                    widget = wibox.widget.background,
                    forced_height = 500
                },
                widget = wibox.container.place,
                valign = "center",
            },
            widget = wibox.container.background,
            bg = "#00000000",
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 5)
            end,
            forced_height = 200
        },
        widget = wibox.container.margin,
        margins = {top=200, left = 1, right = 1 }
    }

    return AI_bar
end

return { integrations = integrations }
