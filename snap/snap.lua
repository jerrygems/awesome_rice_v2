local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
-- local mg = require("mousegrabber")
local naughty = require("naughty")

local snap_distance = 100 -- Snap threshold in pixels

local box = wibox {
    screen = awful.screen.focused(),
    x = 500,
    y = 500,
    width = 10,
    height = 600,
    bg = "#00ffff00",
    ontop = true,
    visible = false,
    shape = gears.shape.rectangle,
    border_width = 2,
    border_color = "#ffff00"
}

local function snapy(c)
    local workarea = awful.screen.focused().workarea
    local geo = c:geometry()
    box.visible = false
    -- left
    if math.abs(geo.x - workarea.x) < snap_distance then
        box.x = workarea.x
        box.y = geo.y + geo.height / 2 - box.height / 2
        box.visible = true
        -- right
    elseif math.abs((geo.x + geo.width) - (workarea.x + workarea.width)) < snap_distance then
        box.x = workarea.x + workarea.width - box.width
        box.y = geo.y + geo.height / 2 - box.height / 2
        box.visible = true
        -- top
    elseif math.abs(geo.y - workarea.y) < snap_distance then
        return nil
        -- bottom
    elseif math.abs((geo.y + geo.height) - (workarea.y + workarea.height)) < snap_distance then
        return nil
        -- top-left
    elseif math.abs((geo.x - workarea.x)) < snap_distance and math.abs((geo.y - workarea.y)) < snap_distance then
        return nil
        -- top-right
    elseif math.abs((geo.x + geo.width) - (workarea.x + workarea.width)) < snap_distance and math.abs((geo.y - workarea.y)) < snap_distance then
        return nil
        -- bottom-left
    elseif math.abs((geo.y + geo.height) - (workarea.y + workarea.height)) < snap_distance and math.abs((geo.x - workarea.x)) < snap_distance then
        return nil
        -- bottom-right
    elseif math.abs((geo.y + geo.height) - (workarea.y + workarea.height)) < snap_distance and math.abs((geo.x + geo.width) - (workarea.x + workarea.width)) < snap_distance then
        return nil
    end
end

-- client.connect_signal("mouse::move", function(c)
--     if c.floating then
--         snapy(c)
--     end
-- end)
-- client.connect_signal("mouse::leave", function(c)
--     if c.floating then
--         box.visible = false
--     end
-- end)
-- client.connect_signal("request::move", function(c)
--     -- Custom behavior when a client requests to move
--     naughty.notification({ text = "Client requested to move: " .. c.name })
-- end)


