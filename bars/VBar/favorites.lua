local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local naughty = require("naughty")

local function favouriteList(s)
    local HT = s.geometry.height
    local WT = s.geometry.width

    local item1 = wibox.widget {
        widget = wibox.widget.textbox,
        text = "Favorite 1",
    }
    local favList = wibox.widget {
        layout = wibox.layout.fixed.vertical,
        {
            widget = wibox.widget.background,
            bg = "#00000099",
            forced_height = HT*(24/100),
            forced_width = 2,
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 5)
            end,
        },
    }
    return wibox.container.margin(favList,5,5,HT*(4/100),0)
end

return { favouriteList = favouriteList }

































-- update_callback = function(self, tag, index)
-- local anime = rubato.timed {
--     duration = 0.5,
--     easing = rubato.easing.linear,
--     override_dt = true,
-- }
-- anime:subscribe(function(pos)
-- prev_tag = awful.tag.history.restore(s)
-- if prev_tag then
--     prev_tag.forced_height = HT * (2.5 / 100) - (HT * (1.3 / 100) * pos)
-- end
-- naughty.notification({text="prev_tag : ".. prev_tag})
-- if index == s.selected_tag.index then
--     self.forced_height = HT * (1.2 / 100) + (HT * (1.3 / 100))
--     prev_tag = index
--     naughty.notification({ text = " " .. prev_tag })
-- else
--     self.forced_height = HT * (2.5 / 100) - (HT * (1.2 / 100))
-- end
-- end)
-- anime.target = 1
-- prev_tag=index
-- end,
