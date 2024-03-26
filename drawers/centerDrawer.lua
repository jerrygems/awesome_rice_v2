local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local home_dir = os.getenv("HOME")


local img1 = home_dir .. "/.config/awesome/icons/power.svg"
local img2 = home_dir .. "/.config/awesome/icons/reboot.svg"
local img3 = home_dir .. "/.config/awesome/icons/lockscreen.svg"

local gen = function(ic, txt, cmd)
    local imgbox = wibox.widget {
        widget = wibox.widget.imagebox,
        image = ic,
        forced_height = 120,
        forced_width = 120
    }
    local btn = wibox.widget {
        {

            {
                {

                    {
                        imgbox,
                        widget = wibox.container.place,
                    },
                    {
                        {
                            widget = wibox.widget.textbox,
                            markup = "<span color='#ffffff'>" .. txt .. "</span>",
                            font = "Monoton 25"
                        },
                        widget = wibox.container.place,
                    },
                    layout = wibox.layout.fixed.vertical

                },

                widget = wibox.container.place,

            },
            widget = wibox.container.background,
            forced_height = 220,
            forced_width = 200,
            bg = "#00000000",
        },
        widget = wibox.container.margin,
        margins = { top = 10, bottom = 10, left = 10, right = 10 },

    }
    btn:connect_signal("mouse::enter", function()
        imgbox.image = gears.color.recolor_image(ic, "#ff035bff")
    end)
    btn:connect_signal("mouse::leave", function()
        imgbox.image = gears.color.recolor_image(ic, "#ffffffff")
    end)
    btn:buttons(
        gears.table.join(
            awful.button({}, 1, function()
                awful.spawn.easy_async(cmd, function()
                    return nil
                end)
            end)
        )
    )

    return btn
end
local function btmDrawer()
    local draw = awful.popup {


        widget    = wibox.widget {
            {
                gen(img1, "shutdown", "shutdown now"),
                gen(img2, "reboot", "reboot"),
                gen(img3, "lock   ", "i3lock-fancy"),
                layout = wibox.layout.flex.horizontal
            },
            bg = "#00000099",
            forced_height = 240,
            forced_width = 800,
            widget = wibox.container.background,
        },
        bg        = "#00000000",
        placement = awful.placement.centered,
        shape     = gears.shape.rounded_rect,
        visible   = true,
    }

    return draw
end

return btmDrawer
