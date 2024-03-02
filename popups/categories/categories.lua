local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")
local shortcuts = require("popups.categories.shortcuts")


local function categories(name, shortcuts_obj)
    local widget_list = wibox.widget {
        layout = wibox.layout.grid,
        forced_num_cols = 3,
    }

    for _, shortcut_in_shortcuts_obj in ipairs(shortcuts_obj) do
        local shortcut_widget = shortcuts.shortcuts(shortcut_in_shortcuts_obj.path, shortcut_in_shortcuts_obj.link)
        widget_list:add(shortcut_widget)
    end
    local box = wibox.widget {
        {
            {
                widget_list,
                widget = wibox.container.background,
                bg = "#00ff0077",
                forced_height = 150,
                forced_width = 180,
                shape = function(cr, width, height)
                    gears.shape.rounded_rect(cr, width, height, 10)
                end
            },
            widget = wibox.container.margin,
            margins = { top = 12, bottom = 12, left = 6, right = 6 }
        },
        widget = wibox.container.background,
        bg = "#00000077"

    }
    return box
end
return { categories = categories }
