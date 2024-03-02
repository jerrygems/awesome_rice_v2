local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")
local shortcuts_list = require("confs.bookmarks_list")

local function shortcuts(path, link)
    local button = wibox.widget {
        {
            image = "https://img.freepik.com/free-vector/realistic-neon-lights-background_23-2148907367.jpg?w=1060&t=st=1709381772~exp=1709382372~hmac=48cf5a3fc4e003759ffd73d55518654b6cd16a3d5d2af7e2161b5a99a66f7e42",
            widget = wibox.widget.imagebox,
        },
        widget = wibox.container.margin,
        margins = { top = 1, bottom = 1, left = 1, right = 1 },
        forced_width = 50,
        forced_height = 50
    }
    button:buttons(
        gears.table.join(
            awful.button({}, 1, function()
                -- naughty.notification({ text = "path : " .. path .. ", link : " .. link })
            end)
        )
    )
    local box = wibox.widget {
        button,
        widget = wibox.container.background,
        bg = "#e7e7e777"
    }
    return box
end

return { shortcuts = shortcuts }
