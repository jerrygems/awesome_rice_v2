local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local shortcuts_list = require("confs.bookmarks_list")
local getimg = require("scripts.getImage")
local naughty = require("naughty")


local function refreshBtn()
    local button = wibox.widget {
        {
            {
                widget = wibox.widget.textbox,
                font = "18 JetBrainsMono",
                text = "Refresh",
            },
            widget = wibox.container.margin,
            margins = { top = 5, bottom = 5, left = 10, right = 10 }
        },
        widget = wibox.container.background,
        bg = "#ff0000",
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 6)
        end
    }
    button:buttons(
        gears.table.join(
            awful.button({}, 1, function()
                for _, category_data in pairs(shortcuts_list) do
                    for _, shortcut in ipairs(category_data.shortcuts) do
                        naughty.notification({ text = " " .. shortcut.link })
                    end
                end
            end)
        )
    )
    local box = wibox.widget {

        {
            button,
            widget = wibox.container.background,
            bg = "#ffffff77",
            layout = wibox.layout.align.horizontal,
            align = "left",
        },
        widget = wibox.container.margin,
        margins = { top = 20, bottom = 10, left = 20, right = 0 },

    }

    return box
end
return { refreshBtn = refreshBtn }
