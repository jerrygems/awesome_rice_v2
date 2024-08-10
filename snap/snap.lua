local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local naughty = require("naughty")

local snap_distance = 10 -- Snap threshold in pixels

local function create_snap_indicator()
    return wibox {
        screen = awful.screen.focused(),
        x = 0,
        y = 0,
        width = 5,
        height = 5,
        bg = "#ff0000", -- Color of the indicator
        ontop = true,
        visible = false,
        shape = gears.shape.rectangle
    }
end

local snap_indicator = create_snap_indicator()

client.connect_signal("mouse::move", function(c)
    if not c.floating then return end

    local warea = awful.screen.focused().workarea
    local geo = c:geometry()
    -- naughty.notification({ text = geo.x .. " : " .. warea.x })
    if math.abs(geo.x - warea.x) < snap_distance then
        -- naughty.notification({ text = math.abs(geo.x - warea.x) .. " : " .. snap_distance })
    elseif math.abs((geo.x+geo.width)-(warea.x+warea.width)) < snap_distance then
            naughty.notification({ text = math.abs(geo.x - geo.width) .. " : " .. snap_distance })
    else
        naughty.notification({text="else"})
    end

end)
