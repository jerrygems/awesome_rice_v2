local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local config = require("confs.config").vars

local function tasklistBar(s)
    local tasklist = awful.widget.tasklist({
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        style = {
            bg = "#00000099",
            fg = '#000000',
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 5)
            end
        },
        layout = {
            spacing = 5,
            layout = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {

                {
                    id = 'icon_role',
                    widget = wibox.widget.imagebox
                },
                margins = 5,
                widget = wibox.container.margin
            },
            widget = wibox.container.background,
            forced_height = 30,
            forced_width = 30,
            bg = config.TB_task_bg,
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 5)
            end
        }

    })

    local c2 = wibox.widget {
        {

            {
                {
                    {
                        tasklist,
                        widget = wibox.container.constraint,
                        width = config.TB_task_mx_width
                    },
                    widget = wibox.container.background,
                    bg = config.TB_task_back_bg,
                    shape = function(cr, width, height)
                        gears.shape.rounded_rect(cr, width, height, 5)
                    end
                },
                widget = wibox.container.margin,
                margins = config.TB_task_df_mgs
            },
            widget = wibox.container.place,
            halign = "left"
        },
        widget = wibox.container.background,
        forced_width = config.TB_task_width
    }

    return c2
end
return {
    tasklistBar = tasklistBar
}
