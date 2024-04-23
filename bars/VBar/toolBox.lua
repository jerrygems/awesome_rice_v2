local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local naughty = require("naughty")
local getImage = require("scripts.getImage")


local home_dir = os.getenv("HOME")
local imga = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/discord.svg", "#ff035bff")
local imgb = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/flameshot.svg", "#ff035bff")
local imgc = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/obsidian.svg", "#ff035bff")
local imgd = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/vbox.png", "#ff035bff")
local imge = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/spotify.png", "#ff035bff")
local imgf = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/reddit.png", "#ff035bff")


local img
local function getimg(imgPath)
    naughty.notification({ text = "" .. imgPath })
end

local function toolBoxBar(s)
    local HT = s.geometry.height
    local WT = s.geometry.width




    local tool1 = wibox.widget {
        widget = wibox.widget.imagebox,
        image = imga
    }
    tool1:connect_signal("mouse::enter", function()
        tool1.image = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/discord.svg", "#7289da")
    end)
    tool1:connect_signal("mouse::leave", function()
        tool1.image = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/discord.svg", "#ff035bff")
    end)
    tool1:buttons(
        gears.table.join(
            awful.button({}, 1, function()
                awful.spawn.easy_async("discord' ", function()
                    return nil
                end)
            end)
        )
    )



    local tool2 = wibox.widget {
        widget = wibox.widget.imagebox,
        image = imgb
    }
    tool2:connect_signal("mouse::enter", function()
        tool2.image = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/flameshot.svg", "#FF4D00")
    end)
    tool2:connect_signal("mouse::leave", function()
        tool2.image = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/flameshot.svg", "#ff035bff")
    end)
    tool2:buttons(
        gears.table.join(
            awful.button({}, 1, function()
                awful.spawn.easy_async("flameshot gui", function()
                    return nil
                end)
            end)
        )
    )



    local tool3 = wibox.widget {
        widget = wibox.widget.imagebox,
        image = imgc
    }
    tool3:connect_signal("mouse::enter", function()
        tool3.image = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/obsidian.svg", "#00F0FF")
    end)
    tool3:connect_signal("mouse::leave", function()
        tool3.image = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/obsidian.svg", "#ff035bff")
    end)
    tool3:buttons(
        gears.table.join(
            awful.button({}, 1, function()
                naughty.notification({ text = "Wait a bit jerry it may take some time" })
                awful.spawn.easy_async("obsidian", function()
                    return nil
                end)
            end)
        )
    )



    local tool4 = wibox.widget {
        widget = wibox.widget.imagebox,
        image = imgd
    }
    tool4:connect_signal("mouse::enter", function()
        tool4.image = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/vbox.png", "#FFD154")
    end)
    tool4:connect_signal("mouse::leave", function()
        tool4.image = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/vbox.png", "#ff035bff")
    end)
    tool4:buttons(
        gears.table.join(
            awful.button({}, 1, function()
                awful.spawn.easy_async("virtualbox", function()
                    return nil
                end)
            end)
        )
    )



    local tool5 = wibox.widget {
        widget = wibox.widget.imagebox,
        image = imge
    }
    tool5:connect_signal("mouse::enter", function()
        tool5.image = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/spotify.png", "#1DB954")
    end)
    tool5:connect_signal("mouse::leave", function()
        tool5.image = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/spotify.png", "#ff035bff")
    end)
    tool5:buttons(
        gears.table.join(
            awful.button({}, 1, function()
                awful.spawn.easy_async("spotify", function()
                    return nil
                end)
            end)
        )
    )



    local tool6 = wibox.widget {
        widget = wibox.widget.imagebox,
        image = imgf
    }
    tool6:connect_signal("mouse::enter", function()
        tool6.image = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/reddit.png", "#FB6950")
    end)
    tool6:connect_signal("mouse::leave", function()
        tool6.image = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/reddit.png", "#ff035bff")
    end)
    tool6:buttons(
        gears.table.join(
            awful.button({}, 1, function()
                awful.spawn.easy_async("firefox 'https://www.reddit.com/user/Sp1d3y001/'", function()
                    return nil
                end)
            end)
        )
    )
    local toolBox = wibox.widget {
        layout = wibox.layout.fixed.vertical,
        {
            {
                {
                    wibox.container.margin(tool1, 5, 5, 8, 8),
                    wibox.container.margin(tool2, 5, 5, 8, 8),
                    wibox.container.margin(tool3, 5, 5, 8, 8),
                    wibox.container.margin(tool4, 5, 5, 8, 8),
                    wibox.container.margin(tool5, 5, 5, 8, 8),
                    wibox.container.margin(tool6, 5, 5, 8, 8),
                    layout = wibox.layout.flex.vertical,
                },
                widget = wibox.container.place,
            },
            widget = wibox.widget.background,
            bg = "#00000099",
            forced_height = HT * (26 / 100),
            forced_width = 2,
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 5)
            end,
        },
    }
    return wibox.container.margin(toolBox, 3, 3, HT * (10 / 100), 0)
end

return { toolBoxBar = toolBoxBar }
