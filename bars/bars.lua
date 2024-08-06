local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local taglist = require("bars.VBar.taglist")
local tools = require("bars.VBar.toolBox")
local task = require("bars.HBar.tasklist")
local activity = require("bars.HBar.activity")
local gizmo = require("bars.HBar.gizmo")
local systray = require("systray.systray")
local bottomBar = require("bars.Bbar.Bbar")
local favs = require("bars.VBar.favorites")
local integrate = require("bars.integrations.integrations")

local config = require("confs.config").vars

local bars = {}
bars.instances = {}

function bars.create()
    awful.screen.connect_for_each_screen(function(s)
        if s.index == 1 then
            s.left_bar = awful.wibar({
                position = "left",
                screen = s,
                type = "normal",
                width = s.geometry.width * (config.LB_width / 100),
                height = s.geometry.height * (config.LB_height / 100),
                visible = config.LB_visible,
                margins = {
                    left = config.LB_MG_left,
                    right = config.LB_MG_right
                },
                bg = config.LB_bg,
                fg = config.LB_fg,
                ontop = config.LB_ontop,
                shape = function(cr, width, height)
                    gears.shape.rounded_rect(cr, width, height, config.LB_radius)
                end
            })

            s.left_bar:setup {
                layout = wibox.layout.align.vertical,
                taglist.taglist_fun(s),
                tools.toolBoxBar(s)
            }

            s.top_bar = awful.wibar({
                position = "top",
                screen = s,
                type = "normal",
                width = s.geometry.width * (config.TB_width / 100),
                height = s.geometry.height * (config.TB_height / 100),
                visible = config.TB_visible,
                margins = {
                    top = config.TB_MG_top,
                    bottom = config.TB_MG_bottom
                },
                bg = config.TB_bg,
                fg = config.TB_fg,
                ontop = config.TB_ontop,
                shape = function(cr, width, height)
                    gears.shape.rounded_rect(cr, width, height, config.TB_radius)
                end
            })
            s.top_bar:setup {
                layout = wibox.layout.align.horizontal,
                {
                    task.tasklistBar(s),
                    activity.activityBar(s),
                    widget = wibox.container.place,
                    layout = wibox.layout.fixed.horizontal
                },
                wibox.container.place(gizmo.gizmoZ(s), "right", "center"),
                wibox.container.place(systray.systray(s), "right", "center")
            }

            s.bottom_bar = awful.wibar({
                position = "bottom",
                screen = s,
                type = "normal",
                width = s.geometry.width * (config.BB_width / 100),
                height = s.geometry.height * (config.BB_height / 100),
                visible = config.BB_visible,
                margins = {
                    top = config.BB_MG_top,
                    bottom = config.BB_MG_bottom,
                },
                bg = config.BB_bg,
                fg = config.BB_fg,
                ontop = config.BB_ontop,
                shape = function(cr, width, height)
                    gears.shape.rounded_rect(cr, width, height, config.BB_radius)
                end
            })

            s.bottom_bar:setup {
                layout = wibox.layout.align.horizontal,
                bottomBar.Bbar(s)
            }


            s.integration_bar = awful.wibar({
                position = "right",
                screen = s,
                type = "normal",
                width = s.geometry.width * (config.RB_width / 100),
                height = s.geometry.height * (config.RB_height / 100),
                visible = config.RB_visible,
                margins = {
                    right = config.RB_MG_right,
                    left = config.RB_MG_left
                },
                bg = config.RB_bg,
                fg = config.RB_fg,
                ontop = config.RB_ontop,
                shape = function(cr, width, height)
                    gears.shape.rounded_rect(cr, width, height, config.RB_radius)
                end
            })
            s.integration_bar:setup {
                integrate.integrations(s),
                favs.favourites(s),
                layout = wibox.layout.flex.vertical
            }
        end


        bars.instances[s] = { s.left_bar, s.top_bar, s.bottom_bar, s.integration_bar }
    end)
end

function bars.all_toggle_bar_visibility()
    for _, barrs in pairs(bars.instances) do
        for _, barr in ipairs(barrs) do
            barr.visible = not barr.visible
        end
    end
end

function bars.basic_toggle_bar_visibility()
    for _, barrs in pairs(bars.instances) do
        for index, barr in ipairs(barrs) do
            if index ~= 2 then
                barr.visible = not barr.visible
            end
        end
    end
end

function bars.toggle_one_bar(num)
    for _, barrs in pairs(bars.instances) do
        for index, barr in ipairs(barrs) do
            if index == num then
                barr.visible = not barr.visible
            end
        end
    end
end

return bars
