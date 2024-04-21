local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

-- local titlebar_tb = {}
local home_dir = os.getenv("HOME")
local function titlebar(c)
    local top_titlebar = awful.titlebar(c, {
        height    = 50,
        bg_normal = '#ff000000',
        bg_active = '#00ffff'
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
        c:kill()
    end)
    maxbtn:connect_signal("mouse::enter", function()
        maxbtn.image = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/reddit.png", "#111111")
    end)
    maxbtn:connect_signal("mouse::leave", function()
        maxbtn.image = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/reddit.png", "#87cb28")
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
                maxbtn,
                closebtn,
                layout = wibox.layout.fixed.horizontal()
            },
            layout = wibox.layout.align.horizontal
        },
        widget = wibox.widget.background,
        bg = "#00000000",

    }
end

return titlebar
