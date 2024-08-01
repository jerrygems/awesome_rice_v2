local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local lfs = require("lfs")
local bars = require("bars.bars")

local home_dir = os.getenv("HOME")



local function btngen(name, img, match_string, opposite_string, status_cmd, toggle_cmd, enabled_color)
    local function file_exists(str)
        local attrib = lfs.attributes(str)
        return attrib and attrib.mode == "file"
    end

    local icon

    if file_exists(img) then
        icon = wibox.widget {
            {
                widget = wibox.widget.imagebox,
                image = img,
            },
            widget = wibox.container.margin,
            margins = 8
        }
    else
        icon = wibox.widget {

            {
                id = "text_icon",
                widget = wibox.widget.textbox,
                text = "" .. img .. " ",
                font = "KodeMono 20",
                align = "center",
                valign = "center",
            },
            widget = wibox.container.margin,
            margins = { left = 10, right = 6, top = 8, bottom = 8 },

        }
    end

    local btn = wibox.widget {
        {
            {
                icon,
                widget = wibox.container.place,
                align = 'center',
                valign = 'center',
            },
            id = "background",
            widget = wibox.container.background,
            bg = "#00000099",
            forced_height = 50,
            forced_width = 58,
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 10)
            end

        },
        widget = wibox.container.margin,
        margins = { top = 8, bottom = 6, left = 6, right = 6 }
    }
    local button_state = nil
    local function update_state()
        awful.spawn.easy_async_with_shell(status_cmd, function(stdout)
            local is_active = stdout:match(match_string)
            button_state = is_active and match_string or opposite_string
            if enabled_color ~= nil then
                btn:get_children_by_id('background')[1].bg = button_state == match_string and enabled_color or
                    "#00000099"
            else
                btn:get_children_by_id('background')[1].bg = button_state == match_string and "#00ff0077" or "#00000099"
            end
        end)
    end

    gears.timer {
        timeout = 0.5,
        autostart = true,
        callback = update_state
    }

    btn:buttons(
        gears.table.join(
            awful.button({}, 1, function()
                if (type(toggle_cmd) == "function") then
                    toggle_cmd()
                else
                    awful.spawn.with_shell(toggle_cmd, function()
                        -- Update the button status after toggling
                        update_state()
                    end)
                end
            end)
        )
    )
    btn:connect_signal("mouse::enter", function()
        btn:get_children_by_id("background")[1].bg = "#44444499"
    end)
    btn:connect_signal("mouse::leave", function()
        update_state()
    end)


    return btn
end

local function buttonBox(s)
    local function close_all_client()
        for _, c in ipairs(client.get()) do
            c:kill()
        end
    end


    return wibox.widget {
        {
            {
                widget = wibox.widget.textbox,
                markup = "SwitchBoard Xd",
                font = "JetBrainsMono Bold 20",
                forced_height = 60
            },
            widget = wibox.container.place
        },
        {

            {
                {
                    {
                        btngen("WiFi", "󰤨", "enabled", "disabled", "nmcli radio wifi", "if [ $(nmcli radio wifi) == 'enabled' ]; then nmcli radio wifi off ; else nmcli radio wifi on ; fi", "#fc7b0377"),
                        btngen("Bluetooth", "", "yes", "", "bluetoothctl show | grep 'Powered: yes' | awk '{print $2}'", "if bluetoothctl show | grep -q 'Powered: yes'; then bluetoothctl power off; else bluetoothctl power on; fi", "#0352fc77"),
                        btngen("Volume Mute", "󰝟", "1", "", "pulsemixer --get-mute", "if [ $(pulsemixer --get-mute) == '1' ] ; then pulsemixer --unmute ; else pulsemixer --mute; fi", "#99020277"),
                        btngen("Volume Medium", "󰖀", "50 50", "", "pulsemixer --get-volume", "if [ \"$(pulsemixer --get-volume)\" = \"50 50\" ]; then echo 1; else pulsemixer --set-volume 50; fi", "#fc450377"),
                        btngen("Volume Full", "󰕾", "100 100", "", "pulsemixer --get-volume", "if [ \"$(pulsemixer --get-volume)\" = \"100 100\" ]; then echo 1; else pulsemixer --set-volume 100; fi", "#ff412b"),
                        btngen("Bars Toggle", "󱒆", "", "", "", function()
                            bars.funbars(s).toggler_for_all_bar()
                        end),
                        btngen("Lock", "󰷛", "yes", "no", "", "i3lock-fancy"),
                        btngen("Close All Windows", "", "yes", "no", "", function()
                            close_all_client()
                        end),
                        btngen("Brightness Decrease", "󰃞", "yes", "no", "", "brightnessctl set 10%-"),
                        btngen("Brightness Increase", "󰃠", "yes", "no", "", "brightnessctl set 10%+"),
                        btngen("Layout", "", "yes", "no", "", function()
                            awful.layout.inc(1)
                        end),
                        btngen("Notification Toggle", "󰎟", "", "", "", ""),
                        btngen("Screen Recording", "󰑋", "yes", "no", "", "vokoscreenNG"),
                        btngen("ScreenShot", "", "yes", "no", "", "flameshot gui"),
                        btngen("File Manager", "󱧷", "yes", "no", "", "thunar"),
                        layout = wibox.layout.grid,
                        homogeneous = true,
                        orientation = 'vertical',
                        forced_num_cols = 5,
                        forced_num_rows = 3
                    },
                    widget = wibox.container.place,
                    align = 'center',
                    valign = 'center',
                },
                widget = wibox.container.background,
                forced_height = 220,
                forced_width = 300,
                bg = "#00000099",
                shape = function(cr, width, height)
                    gears.shape.rounded_rect(cr, width, height, 10)
                end
            },
            widget = wibox.container.margin,
            margins = { left = 10, right = 10 }
        },
        layout = wibox.layout.fixed.vertical,
        spacing = 10
    }
end

return buttonBox
