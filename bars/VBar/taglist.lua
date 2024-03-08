local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local rubato = require("lib.rubato")
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
                visible = false, --text visibility
                widget = wibox.widget.textbox
            },
            margins = { 5, 5, 5, 5 },
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
                    self.animate.target = 30
                else
                    self.animate.target = 15
                end
            end
            self.update()
        end,

        update_callback=function (self)
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
                gears.shape.rounded_rect(cr, width, height, 20)
            end,
            bg_empty = "#ffffffcc",
            bg_occupied = "#6e96f9",
            bg_focus = "#ffffffff",
            bg_urgent = "#ff3d74"

        }
    }


    local wrapper = wibox.container.background(
        wibox.container.margin(taglist, 8, 8, 14, 14),
        -- "#000000dd",
        "#00000099",
        function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 5)
        end
    )
    return wibox.container.margin(wrapper, 5, 5, 5, 5)
end

return {
    taglist_fun = taglist_fun
}
