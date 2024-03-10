local wibox = require("wibox")
local gears = require("gears")
local vicious = require("vicious")
local rubato = require("lib.rubato")
local naughty = require("naughty")
local awful = require("awful")

local function ArcBox(s)
    local arc1 = wibox.widget {
        id = "arc1",
        max_value = 100,
        min_value = 10,
        thickness = 12,
        start_angle = 0,
        -- end_angle = 0 * math.pi / 180,
        rounded_edge = true,
        bg = "#00000000",
        colors = { "#ffff00" },
        widget = wibox.container.arcchart,
    }
    arc1.animate = rubato.timed {
        duration = 0.5,
        override_dt = true,
        subscribed = function(pos)
            arc1:get_children_by_id('arc1')[1].value = pos
        end
    }
    arc1.update = function(arg)
        -- naughty.notification({ text = "" .. cpuval })
        arc1.animate.target = arg
    end

    vicious.register(arc1, vicious.widgets.cpu, function(widget, args)
        arc1.update(tonumber(args[1]))
    end, 0.5)




    local arc2 = wibox.widget {
        id = "arc2",
        value = 100,
        max_value = 100,
        min_value = 10,
        thickness = 12,
        start_angle = 0,
        -- end_angle = 0 * math.pi / 180,
        rounded_edge = true,
        bg = "#00000000",
        colors = { "#ffff00" },
        widget = wibox.container.arcchart,
    }
    arc2.animate = rubato.timed {
        duration = 0.5,
        subscribed = function(pos)
            arc2:get_children_by_id('arc2')[1].value = pos
        end
    }
    arc2.update = function(arg)
        -- naughty.notification({ text = "" .. cpuval })
        arc2.animate.target = arg
    end

    vicious.register(arc2, vicious.widgets.mem, function(widget, args)
        arc2.update(tonumber(args[1]))
    end, 0.5)


    local arc3 = wibox.widget {
        id = "arc3",
        value = 100,
        max_value = 100,
        thickness = 12,
        start_angle = 10 * math.pi / 180,
        -- end_angle = 0 * math.pi / 180,
        rounded_edge = true,
        bg = "#00000000",
        colors = { "#ffff00" },
        widget = wibox.container.arcchart,
    }
    arc3.animate = rubato.timed {
        duration = 0.5,
        easing = rubato.easing.cubicInOut,
        subscribed = function(pos)
            arc3:get_children_by_id('arc3')[1].value = pos
        end
    }
    arc3.update = function(arg)
        -- naughty.notification({ text = "" .. cpuval })
        arc3.animate.target = arg
    end

    vicious.register(arc3, vicious.widgets.mem, function(widget, args)
        arc3.update(tonumber(args[1]))
    end, 0.5)




    local arc4 = wibox.widget {
        id = "arc4",
        value = 100,
        max_value = 100,
        thickness = 12,
        start_angle = 10 * math.pi / 180,
        -- end_angle = 0 * math.pi / 180,
        rounded_edge = true,
        bg = "#00000000",
        colors = { "#ffff00" },
        widget = wibox.container.arcchart,
    }

    arc4.animate = rubato.timed {
        duration = 0.5,
        subscribed = function(pos)
            arc4:get_children_by_id('arc4')[1].value = pos
        end
    }
    arc4.update = function(arg)
        -- naughty.notification({ text = "" .. cpuval })
        arc4.animate.target = arg
    end

    vicious.register(arc3, vicious.widgets.mem, function(widget, args)
        arc4.update(tonumber(args[1]))
    end, 0.5)




    local box = wibox.widget {
        {
            {
                arc1,
                arc2,
                arc3,
                arc4,

                layout = wibox.layout.grid.horizontal,
                forced_num_rows = 2,
                expand = true,
                spacing = 10
            },
            widget = wibox.container.margin,
            margins = { top = 10, bottom = 10, left = 10, right = 10 }
        },

        widget = wibox.container.background,
        forced_height = 150,
        forced_width = 150,
        bg = "#000000ff",
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 10)
        end
    }

    return box
end

return { ArcBox = ArcBox }
