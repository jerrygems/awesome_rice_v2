local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local rubato = require("lib.rubato")
local beautiful = require("beautiful")
local naughty = require("naughty")


local function taglist_fun(s)
    local prev_tag = nil
    local HT = s.geometry.height
    local WT = s.geometry.width
    -- naughty.notification({ text = " : " .. index .. " : " .. tostring(tag)   })
    local taglist_template = {
        {
            {
                id = 'text_role',
                align = 'center',
                valign = 'center',
                visible = false,--text visibility
                widget = wibox.widget.textbox
            },
            margins = {5,5,5,5},
            widget = wibox.container.margin
        },
        id = 'background_role',
        widget = wibox.container.background,
        update_callback = function()
            -- naughty.notification({ text = " : " .. index .. " : " .. tostring(tag)   })
        end,

        create_callback = function(self, tag, index)
            if index == s.selected_tag.index then
                self.forced_height = HT * (1.2 / 100) + (HT * (1.3 / 100))
            else
                self.forced_height = HT * (2.5 / 100) - (HT * (1.3 / 100))
            end
        end,

    }

    local taglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        layout = {
            layout = wibox.layout.fixed.vertical
        },
        widget_template = taglist_template,

        style = {
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 30)
            end,
            spacing = 15,
            shape_empty = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 30)
            end,
            bg_empty = "#ffffff",
            bg_occupied = "#57ffab",
            bg_focus = "#6e96f9",
            bg_urgent = "#ff3d74"

        }
    }

    s:connect_signal("property::selected", function()
        naughty.notification({ text = " : " ..
        tostring(awful.screen.focused().selected_tag) .. " : " .. awful.screen.focused().selected_tag.index })
    end)
    local wrapper = wibox.container.background(
        wibox.container.margin(taglist, 8, 8, 14, 14),
        -- "#000000dd",
        "#00000055",
        function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 5)
        end
    )
    return wibox.container.margin(wrapper, 5, 5, 5, 5)
end

return {
    taglist_fun = taglist_fun
}
