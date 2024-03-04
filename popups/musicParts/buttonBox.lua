local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")


local home_dir = os.getenv("HOME")
local reverse10 = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/10SecRev.svg", "#ffffff")
local play = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/play.svg", "#ffffff")
local pause = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/pause.svg", "#ffffff")
local forward10 = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/10SecForward.svg", "#ffffff")
local repeatit = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/repeat.svg", "#ffffff")
local next = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/next-btn.svg", "#ffffff")
local prev = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/prev-btn.svg", "#ffffff")


local function buttonBox(s)
    local WW = s.geometry.width
    local WH = s.geometry.height



    local status = io.popen("playerctl status", 'r'):read("*a")
    local updater = function()
        status = io.popen("playerctl status", 'r'):read("*a")
    end
    local toggler = wibox.widget {
        image = play,
        widget = wibox.widget.imagebox
    }
    local playbtn = wibox.widget {
        toggler,
        widget = wibox.container.background,
        forced_width = 20
        -- bg = "#ffff00",
    }
    updater()



    gears.timer {
        timeout = 0.5, -- Check every second (adjust as needed)
        autostart = true,
        call_now = false,
        callback = function()
            updater()
            playbtn:buttons(awful.button({}, 1, function()
                if status == "Playing\n" then
                    toggler.image = play
                    awful.spawn.easy_async("playerctl pause", function()
                        return nil
                    end)
                else
                    toggler.image = pause
                    awful.spawn.easy_async("playerctl play", function()
                        return nil
                    end)
                end
            end))
        end
    }


    local revbtn = wibox.widget {
        {

            image = reverse10,
            widget = wibox.widget.imagebox

        },
        widget = wibox.container.background,
        -- bg = "#ffff00",
    }
    revbtn:buttons(
        gears.table.join(
            awful.button({}, 1, function()
                awful.spawn.easy_async("playerctl position 10-", function()
                    return nil
                end)
            end)
        )
    )

    local prevbtn = wibox.widget {
        {

            image = prev,
            widget = wibox.widget.imagebox

        },
        widget = wibox.container.background,
        -- bg = "#ffff00",
    }
    prevbtn:buttons(
        gears.table.join(
            awful.button({}, 1, function()
                awful.spawn.easy_async("playerctl previous", function()
                    return nil
                end)
            end)
        )
    )


    local nextbtn = wibox.widget {
        {

            image = next,
            widget = wibox.widget.imagebox

        },
        widget = wibox.container.background,
        -- bg = "#ffff00",
    }
    nextbtn:buttons(
        gears.table.join(
            awful.button({}, 1, function()
                awful.spawn.easy_async("playerctl next", function()
                    return nil
                end)
            end)
        )
    )

    local forwardbtn = wibox.widget {
        {

            image = forward10,
            widget = wibox.widget.imagebox

        },
        widget = wibox.container.background,
        -- bg = "#ffff00",
    }
    forwardbtn:buttons(
        gears.table.join(
            awful.button({}, 1, function()
                awful.spawn.easy_async("playerctl position 10+", function()
                    return nil
                end)
            end)
        )
    )


    local repeatbtn = wibox.widget {
        {

            image = repeatit,
            widget = wibox.widget.imagebox

        },
        widget = wibox.container.background,
        -- bg = "#ffff00",
    }
    repeatbtn:buttons(
        gears.table.join(
            awful.button({}, 1, function()
                awful.spawn.easy_async("playerctl previous && playerctl next", function()
                    return nil
                end)
            end)
        )
    )


    local btnBox = wibox.widget {
        {
            { -- 10 sec back
                revbtn,
                widget = wibox.container.margin,
                margins = { top = 10, bottom = 10, left = 5, right = 5 }
            },
            { -- prev
                prevbtn,
                widget = wibox.container.margin,
                margins = { top = 10, bottom = 10, left = 5, right = 5 }
            },
            { -- play
                playbtn,
                widget = wibox.container.margin,
                margins = { top = 10, bottom = 10, left = 5, right = 5 }
            },
            {
                nextbtn,
                widget = wibox.container.margin,
                margins = { top = 10, bottom = 10, left = 5, right = 5 }
            },
            { -- 10 sec forward
                forwardbtn,
                widget = wibox.container.margin,
                margins = { top = 10, bottom = 10, left = 5, right = 5 }
            },
            { -- repeat
                repeatbtn,
                widget = wibox.container.margin,
                margins = { top = 10, bottom = 10, left = 5, right = 5 }
            },
            layout = wibox.layout.fixed.horizontal,
            align = "center"
        },
        widget = wibox.container.background,
        bg = "#00000000",
        forced_height = WH * (4 / 100)
    }
    return btnBox
end


return { buttonBox = buttonBox }
