local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local naughty = require("naughty")

local lgi = require 'lgi'
local cairo = lgi.cairo

local width = 350
local height = 350

local values = {
    X = width / 2,
    Y = height / 2,
    radius = 125,
    tick_length = 10,
    special_tick_length = 30,
    hr_hand_len = 40,
    mn_hand_len = 60
}

local helpers = {
    tick_draw = function(a, b, rad, ang, tl)
        local inner_x = values.X + rad * math.cos(ang)
        local inner_y = values.Y + rad * math.sin(ang)
        local outer_x = values.X + (rad - tl) * math.cos(ang)
        local outer_y = values.X + (rad - tl) * math.sin(ang)
        return inner_x, inner_y, outer_x, outer_y
    end,

    hour_hand = function(cr)
        local hr = tonumber(os.date("%I"))
        local min = tonumber(os.date("%M"))

        local hr_angle = ((hr % 12) * 30) + (min * 0.5)
        local hr_radian = (hr_angle - 90) * (math.pi / 180)

        local hr_hand_x = values.X + values.hr_hand_len * (math.cos(hr_radian))
        local hr_hand_y = values.Y + values.hr_hand_len * (math.sin(hr_radian))
        return hr_hand_x, hr_hand_y
    end,

    minute_hand = function(cr)
        local mn = tonumber(os.date("%M"))
        local mn_angle = mn * 6
        local mn_radian = (mn_angle - 90) * math.pi / 180

        local mn_hand_x = values.X + values.mn_hand_len * (math.cos(mn_radian))
        local mn_hand_y = values.Y + values.mn_hand_len * (math.sin(mn_radian))
        return mn_hand_x, mn_hand_y
    end
}

local function draw_mrs_minute(cr)
    cr:set_source_rgba(0, 0, 0, 0)
    cr:paint()

    -- for clock's first circle
    cr:set_source_rgba(239 / 255, 124 / 255, 26 / 255, 1)
    cr:arc(values.X - 10, values.Y + 10, 160, 0, 2 * math.pi)
    cr:fill()
    -- first circle border
    cr:set_source_rgba(0, 0, 0, 1)
    cr:set_line_width(3)
    cr:arc(values.X - 10, values.Y + 10, 160, 0, 2 * math.pi)
    cr:stroke()

    -- for clock's second circle
    cr:set_source_rgba(239 / 255, 124 / 255, 26 / 255, 1)
    cr:arc(values.X, values.Y, 150, 0, 2 * math.pi)
    cr:fill()
    -- second circle border
    cr:set_source_rgba(0, 0, 0, 1)
    cr:set_line_width(3)
    cr:arc(values.X, values.Y, 150, 0, 2 * math.pi)
    cr:stroke()

    -- tick marks
    cr:set_source_rgba(0, 0, 0, 1)
    cr:set_line_width(3)
    for i = 0, 11 do
        local angle = (i * 30) * (math.pi / 180)
        local tick_len = i % 3 == 0 and values.special_tick_length or values.tick_length

        local inner_x, inner_y, outer_x, outer_y = helpers.tick_draw(values.X, values.Y, values.radius, angle, tick_len)
        cr:move_to(outer_x, outer_y)
        cr:line_to(inner_x, inner_y)
        cr:stroke()
    end

    cr:set_source_rgba(0, 0, 0, 1)
    cr:set_line_width(4)
    cr:move_to(values.X, values.Y)
    local hx, hy = helpers.hour_hand(cr)
    cr:line_to(hx, hy)
    cr:stroke()

    cr:set_source_rgba(0, 0, 0, 1)
    cr:set_line_width(4)
    cr:move_to(values.X, values.Y)
    local mx, my = helpers.minute_hand(cr)
    cr:line_to(mx, my)
    cr:stroke()
end
-- Create an image surface
local surface = cairo.ImageSurface(cairo.Format.ARGB32, width, height)
local cr = cairo.Context(surface)

local clock_widget = wibox.widget.imagebox()

local function update_mrs_minute()
    draw_mrs_minute(cr)
    clock_widget.image = surface
end
gears.timer {
    timeout = 20,
    autostart = true,
    callback = update_mrs_minute
}
update_mrs_minute()


local function box(w, h)
    return wibox.widget {
        {
            clock_widget,
            layout = wibox.layout.fixed.horizontal
        },
        widget = wibox.widget.background,
        forced_height = w,
        forced_width = h,
        -- shape = function(context, shape_width, shape_height)
        -- gears.shape.rounded_rect(context, shape_width, shape_height,600)
        -- end,
    }
end


local function mrs_minute(s, w, h, pop_x, pop_y)
    awesome.register_xproperty("WM_NAME", "string")
    awesome.register_xproperty("WM_CLASS", "string")
    local clock_pop = awful.popup {
        widget = box(w, h),
        screen = s,
        x = pop_x,
        y = pop_y,
        ontop = false,
        visible = true,
        bg = "#00000000",
        -- type = "splash",
    }
    clock_pop:set_xproperty("WM_CLASS", "MrsMinute")
    clock_pop:set_xproperty("WM_NAME", "MrsMinute")
    return clock_pop
end


return {
    mrs_minute = mrs_minute
}
