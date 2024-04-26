local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local rubato = require("lib.rubato")
local naughty = require("naughty")
local config = require("confs.config").vars

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
                visible = false,
                widget = wibox.widget.textbox
            },
            margins = {5, 5, 5, 5},
            widget = wibox.container.margin
        },
        id = 'background_role',
        widget = wibox.container.background,

        create_callback = function(self, tag, index)
            self.animate = rubato.timed {
                duration = 0.15,
                subscribed = function(pos)
                    self:get_children_by_id('background_role')[1].forced_height = pos
                end
            }

            self.update = function()
                if tag.selected then
                    self.animate.target = config.tag_height
                else
                    self.animate.target = config.tag_height_on_select
                end
            end
            self.update()
        end,

        update_callback = function(self)
            self.update()
        end

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
                gears.shape.rounded_rect(cr, width, height, 3)
            end,
            spacing = 15,
            shape_empty = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, config.tag_inner_radius)
            end,
            bg_empty = config.tag_bg_empty,
            bg_occupied = config.tag_bg_occupied,
            bg_focus = config.tag_bg_focus,
            bg_urgent = config.tag_bg_urgent

        }
    }

    local wrapper = wibox.widget {
        {
            wibox.container.margin(taglist, 10, 10, 14, 14),
            -- "#000000dd",
            bg = config.tag_bg,
            widget = wibox.container.background,
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, config.tag_wrapper_radius)
            end
        },
        widget = wibox.container.constraint,

        strategy = "exact",
        height = 300
    }
    return wibox.container.margin(wrapper, 3, 3, 100, 0)
end

return {
    taglist_fun = taglist_fun
}
