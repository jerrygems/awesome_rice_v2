local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local categories = require("popups.categories.categories")
local shortcuts = require("popups.categories.shortcuts")
local refreshBtn = require("popups.categories.refresh")
local shortcuts_list = require("confs.bookmarks_list")


local widget_list = wibox.widget {
    widget = wibox.container.background,
    -- bg = "#ffffff",
    layout = wibox.layout.grid,
    forced_num_cols = 5
}

for _, category_data in pairs(shortcuts_list) do
    local category_widget = categories.categories(category_data.name, category_data.shortcuts)
    widget_list:add(category_widget)
end

local function bookmarks()
    local box = wibox.widget {
        {
            {
                { -- heading bookmarks will be here boi
                    {
                        {
                            {
                                widget = wibox.widget.textbox,
                                font = "18 JetBrainsMono",
                                text = "Bookmarks",
                                halign = 'center'
                            },
                            widget = wibox.container.margin,
                            margins = { top = 10, bottom = 10, left = 0, right = 0 },
                        },

                        widget = wibox.container.background,
                        bg = "#ffffff77"
                    },
                    refreshBtn.refreshBtn(),
                    layout = wibox.layout.align.vertical
                },
                {
                    widget_list,
                    widget = wibox.container.place,
                    valign = "center",
                    align = "center"
                },
                layout = wibox.layout.align.vertical,


            },
            widget = wibox.container.margin,
            margins = { top = 0, bottom = 0, left = 0, right = 0 },
        },
        widget = wibox.container.background,
        bg = "#00000077"
    }


    local popup = awful.popup {

        widget = {
            box,
            widget = wibox.container.background,
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 10)
            end,
            bg = "#00000077",
            forced_width = 1000,
            forced_height = 600,
        },
        placement = awful.placement.centered,
        visible = true,
        ontop = false,
        bg = "#00000000",
        -- shape = gears.shape.rounded_rect,
        -- border_width = 2,
        -- border_color = "#000000",
    }
    return popup
end

return { bookmarks = bookmarks }
