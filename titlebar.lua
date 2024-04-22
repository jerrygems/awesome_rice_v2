local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

-- local titlebar_tb = {}
local home_dir = os.getenv("HOME")
local function titlebar(c)
    local top_titlebar = awful.titlebar(c, {
        size       = 26,
        bg         = "#00000099",
        bg_normal  = '#ff000000',
        bg_active  = '#00ffff',
        bg_unfocus = "#ff00ff",
    })
    -- close button
    local closebtn = wibox.widget {
        image = "/home/spidey/.config/awesome/icons/reddit.png",
        widget = wibox.widget.imagebox,
    }
    closebtn:connect_signal("button::press", function()
        c:kill()
    end)
    closebtn:connect_signal("mouse::enter", function()
        closebtn.image = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/reddit.png", "#111111")
    end)
    closebtn:connect_signal("mouse::leave", function()
        closebtn.image = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/reddit.png", "#ff5656")
    end)

    -- minimize and maximize button is here
    local maxbtn = wibox.widget {
        image = "/home/spidey/.config/awesome/icons/reddit.png",
        widget = wibox.widget.imagebox,
    }
    maxbtn:connect_signal("button::press", function()
        c.maximized = not c.maximized
    end)
    maxbtn:connect_signal("mouse::enter", function()
        maxbtn.image = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/reddit.png", "#111111")
    end)
    maxbtn:connect_signal("mouse::leave", function()
        maxbtn.image = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/reddit.png", "#87cb28")
    end)

    -- always on top feature is here
    local alwaysontop = wibox.widget {
        image = "/home/spidey/.config/awesome/icons/reddit.png",
        widget = wibox.widget.imagebox,
    }
    alwaysontop:connect_signal("button::press", function()
        c.ontop = not c.ontop
    end)
    alwaysontop:connect_signal("mouse::enter", function()
        alwaysontop.image = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/reddit.png", "#111111")
    end)
    alwaysontop:connect_signal("mouse::leave", function()
        alwaysontop.image = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/reddit.png", "#87cb28")
    end)

    local buttons = gears.table.join(
        awful.button({}, 1, function()
            c:emit_signal("request::activate", "titlebar", { raise = true })
            awful.mouse.client.move(c)
        end),
        awful.button({}, 3, function()
            c:emit_signal("request::activate", "titlebar", { raise = true })
            awful.mouse.client.resize(c)
        end)
    )

    top_titlebar:setup {
        {
            {
                awful.titlebar.widget.iconwidget(c),
                buttons = buttons,
                layout  = wibox.layout.fixed.horizontal
            },
            {
                {
                    {
                        align  = "center",
                        widget = awful.titlebar.widget.titlewidget(c),
                        font   = "KodeMono 12",
                    },
                    widget = wibox.container.margin,
                    margins = { top = 0, bottom = 0 }
                },
                buttons = buttons,
                layout  = wibox.layout.flex.horizontal
            },
            {

                {
                    widget = wibox.widget.background,
                    bg = "#00ffff77",
                    shape = function(cr, width, height)
                        gears.shape.rounded_rect(cr, width, height, 10)
                    end,
                    forced_width = 100,

                    {
                        wibox.container.margin(alwaysontop, 3, 3, 3, 3),
                        wibox.container.margin(maxbtn, 3, 3, 3, 3),
                        wibox.container.margin(closebtn, 3, 3, 3, 3),
                        layout = wibox.layout.flex.horizontal
                    }
                },
                widget = wibox.container.margin,
                margins = { top = 0, bottom = 0, left = 20, right = 20 }




            },
            layout = wibox.layout.align.horizontal
        },
        widget = wibox.widget.background,
        bg = "#00000000",

    }
end

return titlebar
