local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local naughty = require("naughty")
local config = require("confs.config").vars

local home_dir = os.getenv("HOME")
local imga = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/notebook.svg", config.icons_df_clr_on_hover)
local imgb = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/github.png", config.icons_df_clr_on_hover)
local imgc = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/kaggle.svg", config.icons_df_clr_on_hover)
local imgd = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/gmail.svg", config.icons_df_clr_on_hover)
local imge = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/colab.svg", config.icons_df_clr_on_hover)
local imgf = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/chatgpt.svg", config.icons_df_clr_on_hover)

local function favourites(s)
    local HT = s.geometry.height
    local WT = s.geometry.width

    local tool1 = wibox.widget {
        widget = wibox.widget.imagebox,
        image = imga,
        align = 'center'
    }
    tool1:connect_signal("mouse::enter", function()
        tool1.image = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/notebook.svg", "#fc8403")
    end)
    tool1:connect_signal("mouse::leave", function()
        tool1.image = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/notebook.svg",
            config.icons_df_clr_on_hover)
    end)
    tool1:buttons(gears.table.join(awful.button({}, 1, function()
        awful.spawn.easy_async("jupyter notebook", function()
            return nil
        end)
    end)))

    local tool2 = wibox.widget {
        widget = wibox.widget.imagebox,
        image = imgb
    }
    tool2:connect_signal("mouse::enter", function()
        tool2.image = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/github.png", "#777777")
    end)
    tool2:connect_signal("mouse::leave", function()
        tool2.image = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/github.png",
            config.icons_df_clr_on_hover)
    end)
    tool2:buttons(gears.table.join(awful.button({}, 1, function()
        awful.spawn.easy_async("firefox https://github.com/jerrygems", function()
            return nil
        end)
    end)))

    local tool3 = wibox.widget {
        widget = wibox.widget.imagebox,
        image = imgc
    }
    tool3:connect_signal("mouse::enter", function()
        tool3.image = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/kaggle.svg", "#00F0FF")
    end)
    tool3:connect_signal("mouse::leave", function()
        tool3.image = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/kaggle.svg",
            config.icons_df_clr_on_hover)
    end)
    tool3:buttons(gears.table.join(awful.button({}, 1, function()
        naughty.notification({
            text = "Wait a bit jerry it may take some time"
        })
        awful.spawn.easy_async("firefox https://www.kaggle.com", function()
            return nil
        end)
    end)))

    local tool4 = wibox.widget {
        widget = wibox.widget.imagebox,
        image = imgd
    }
    tool4:connect_signal("mouse::enter", function()
        tool4.image = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/gmail.svg", "#FFD154")
    end)
    tool4:connect_signal("mouse::leave", function()
        tool4.image = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/gmail.svg",
            config.icons_df_clr_on_hover)
    end)
    tool4:buttons(gears.table.join(awful.button({}, 1, function()
        awful.spawn.easy_async("firefox https://gmail.com", function()
            return nil
        end)
    end)))

    local tool5 = wibox.widget {
        widget = wibox.widget.imagebox,
        image = imge
    }
    tool5:connect_signal("mouse::enter", function()
        tool5.image = home_dir .. "/.config/awesome/icons/colab.svg"
    end)
    tool5:connect_signal("mouse::leave", function()
        tool5.image = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/colab.svg",
            config.icons_df_clr_on_hover)
    end)
    tool5:buttons(gears.table.join(awful.button({}, 1, function()
        awful.spawn.easy_async("firefox https://colab.research.google.com", function()
            return nil
        end)
    end)))

    local tool6 = wibox.widget {
        widget = wibox.widget.imagebox,
        image = imgf
    }
    tool6:connect_signal("mouse::enter", function()
        tool6.image = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/chatgpt.svg", "#88a788")
    end)
    tool6:connect_signal("mouse::leave", function()
        tool6.image = gears.color.recolor_image(home_dir .. "/.config/awesome/icons/chatgpt.svg",
            config.icons_df_clr_on_hover)
    end)
    tool6:buttons(gears.table.join(awful.button({}, 1, function()
        awful.spawn.easy_async("firefox https://chat.openai.com/", function()
            return nil
        end)
    end)))
    local toolBox = wibox.widget {
        layout = wibox.layout.fixed.vertical,
        {
            {
                {
                    wibox.container.margin(tool1, 8, 5, 6, 6),
                    wibox.container.margin(tool2, 5, 5, 6, 6),
                    wibox.container.margin(tool3, 10, 5, 6, 6),
                    wibox.container.margin(tool4, 5, 5, 6, 6),
                    wibox.container.margin(tool5, 5, 5, 6, 6),
                    wibox.container.margin(tool6, 5, 5, 6, 6),
                    layout = wibox.layout.flex.vertical
                },
                widget = wibox.container.place
            },
            widget = wibox.widget.background,
            bg = "#00000099",
            forced_height = HT * (24 / 100),
            -- forced_width = 0,
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 5)
            end
        }
    }
    return wibox.container.margin(toolBox, 3, 3, HT * (7 / 100), 0)
end

return {
    favourites = favourites
}
