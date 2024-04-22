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
        image = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/close_shuriken.svg", "#000000"),
        widget = wibox.widget.imagebox,
    }
    closebtn:connect_signal("button::press", function()
        c:kill()
    end)
    closebtn:connect_signal("mouse::enter", function()
        closebtn.image = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/close_shuriken.svg", "#ffffff")
    end)
    closebtn:connect_signal("mouse::leave", function()
        closebtn.image = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/close_shuriken.svg", "#000000")
    end)

    -- minimize and maximize button is here
    local maxbtn = wibox.widget {
        image = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/maximize.svg", "#000000"),
        widget = wibox.widget.imagebox,
    }
    maxbtn:connect_signal("button::press", function()
        c.maximized = not c.maximized
    end)
    maxbtn:connect_signal("mouse::enter", function()
        maxbtn.image = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/maximize.svg", "#ffffff")
    end)
    maxbtn:connect_signal("mouse::leave", function()
        maxbtn.image = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/maximize.svg", "#000000")
    end)

    -- always on top feature is here
    local alwaysontop = wibox.widget {
        image = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/ontop.svg", "#000000"),
        widget = wibox.widget.imagebox,
    }
    alwaysontop:connect_signal("button::press", function()
        c.ontop = not c.ontop
    end)
    alwaysontop:connect_signal("mouse::enter", function()
        alwaysontop.image = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/ontop.svg", "#ffffff")
    end)
    alwaysontop:connect_signal("mouse::leave", function()
        alwaysontop.image = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/ontop.svg", "#000000")
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
                wibox.container.margin(awful.titlebar.widget.iconwidget(c), 20, 20, 3, 3),
                buttons = buttons,
                layout  = wibox.layout.fixed.horizontal
            },
            {
                {
                    {
                        align  = "center",
                        widget = awful.titlebar.widget.titlewidget(c),
                        font   = "KodeMono 10",
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
                    bg = "#00000000",
                    shape = function(cr, width, height)
                        gears.shape.rounded_rect(cr, width, height, 10)
                    end,
                    forced_width = 100,

                    {
                        {
                            widget = wibox.container.margin,
                            margins = { left = 6, right = 6, top = 2, bottom = 2 },
                            {
                                widget = wibox.widget.background,
                                bg = "#00ca4e9cc",
                                shape = function(cr, width, height)
                                    gears.shape.rounded_rect(cr, width, height, 100)
                                end,
                                wibox.container.place(wibox.container.margin(alwaysontop, 4, 4, 4, 4), "center", "center"),
                            }
                        },
                        {
                            widget = wibox.container.margin,
                            margins = { left = 6, right = 6, top = 2, bottom = 2 },
                            {
                                widget = wibox.widget.background,
                                bg = "#ffbd44cc",
                                shape = function(cr, width, height)
                                    gears.shape.rounded_rect(cr, width, height, 100)
                                end,
                                wibox.container.place(wibox.container.margin(maxbtn, 4, 4, 4, 4), "center", "center"),
                            }
                        },
                        {
                            widget = wibox.container.margin,
                            margins = { left = 6, right = 6, top = 2, bottom = 2 },
                            {
                                widget = wibox.widget.background,
                                bg = "#ff605ccc",
                                shape = function(cr, width, height)
                                    gears.shape.rounded_rect(cr, width, height, 100)
                                end,
                                wibox.container.place(wibox.container.margin(closebtn, 4, 4, 4, 4), "center", "center"),
                            }
                        },
                        layout = wibox.layout.flex.horizontal
                    }
                },
                widget = wibox.container.margin,
                margins = { top = 0, bottom = 0, left = 20, right = 0 }
            },
            layout = wibox.layout.align.horizontal
        },
        widget = wibox.widget.background,
        bg = "#ffffff33",

    }
end

return titlebar
