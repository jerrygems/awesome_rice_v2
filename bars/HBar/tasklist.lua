local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local naughty = require("naughty")
local config = require("confs.config").vars

local function tasklistBar(s)
    local tasklist = awful.widget.tasklist({
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        layout = {
            spacing = config.takslist.spacing,
            layout = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                {
                    id = 'icon_role',
                    widget = wibox.widget.imagebox
                },
                margins = config.takslist.ic_box.mg,
                widget = wibox.container.margin
            },
            widget = wibox.container.background,
            forced_height = config.takslist.ic_box.height,
            forced_width = config.takslist.ic_box.width,
            bg = config.takslist.bg,
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, config.takslist.ic_box.radius)
            end,
            create_callback = function(self, c, index, objects)
                local icon = self:get_children_by_id('icon_role')[1]
                icon.client = c
                icon:buttons(awful.button({}, 1, function()
                    if c then
                        client.focus = c
                        c:raise()
                    end
                end))
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
                        width = config.takslist.max_width
                    },
                    widget = wibox.container.background,
                    bg = config.takslist.back_bg,
                    shape = function(cr, width, height)
                        gears.shape.rounded_rect(cr, width, height, config.takslist.radius)
                    end
                },
                widget = wibox.container.margin,
                margins = config.takslist.mg
            },
            widget = wibox.container.place,
            halign = config.takslist.halign
        },
        widget = wibox.container.background,
        forced_width = config.takslist.width
    }

    return c2
end
return {
    tasklistBar = tasklistBar
}
