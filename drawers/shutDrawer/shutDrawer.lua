local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")


local shutDrawer = awful.popup {
    widget = {
        widget = wibox.container.background,
        
    },
    placement = awful.placement.bottom,
    visible = true,
    ontop = false,
    bg = "#00000088",
}



return { shutDrawer = shutDrawer }
