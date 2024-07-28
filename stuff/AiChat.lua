local awful = require("awful")
local naughty = require("naughty")
local wibox = require("wibox")
local gears = require("gears")


-- local function api_request()

-- end


local msgtxt = wibox.widget {
    widget = wibox.widget.textbox,
    markup = "<span font='MadimiOne 14'>Hello there</span>",
    align = 'center'
}
local msgbox = wibox.widget {
    {
        msgtxt,
        widget = wibox.container.background,
        bg = "ff00ff33"
    },
    widget = wibox.container.margin,
    margins = { left = 0, top = 0, right = 0, bottom = 0 }
}

local function AiChat(w, h, posx, posy, bg_color, s)
    local screen_geometry = s.geometry

    local pop_width = screen_geometry.width * (w / 100)
    local pop_height = screen_geometry.height * (h / 100)
    local pop_x = screen_geometry.x + pop_width * posx
    local pop_y = screen_geometry.y + pop_height * posy

    local AiChatPopup = awful.popup {
        widget = {
            {
                {
                    msgbox,
                    widget = wibox.container.background,
                    shape = function(cr, pop_width, pop_height)
                        gears.shape.rounded_rect(cr, pop_width, pop_height, 10)
                    end,
                    bg = bg_color,
                    forced_height = pop_height * 85 / 100,
                },
                {

                    require("stuff.input").inpbox(pop_width, pop_height, bg).input_widget,
                    shape = function(cr, pop_width, pop_height)
                        gears.shape.rounded_rect(cr, pop_width, pop_height, 10)
                    end,
                    widget = wibox.container.background,
                    bg = bg_color,
                    forced_height = pop_height * 15 / 100,
                },
                widget = wibox.layout.fixed.vertical
            },
            shape = function(cr, pop_width, pop_height)
                gears.shape.rounded_rect(cr, pop_width, pop_height, 10)
            end,
            widget = wibox.container.background,
            -- bg = "#00000033",
            forced_width = pop_width,
            forced_height = pop_height,
        },
        screen = s,
        x = pop_x, -- 1300,
        y = pop_y, -- 150,
        visible = true,
        ontop = false,
        bg = bg_color,
    }
    return AiChatPopup
end

return {
    AiChat = AiChat
}
