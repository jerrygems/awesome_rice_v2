local wibox = require("wibox")
local gears = require("gears")
local vicious = require("vicious")
local rubato = require("lib.rubato")
local naughty = require("naughty")
local awful = require("awful")

local function sysperf(s)
    local w1 = wibox.widget {
        markup = "",
        align = "center",
        widget = wibox.widget.textbox,
    }
    vicious.register(w1, vicious.widgets.cpu, "<span color='#04d9ff'>$1%</span>", 2)


    local w2 = wibox.widget {
        markup = "",
        align = "center",
        widget = wibox.widget.textbox,
    }
    vicious.register(w2, vicious.widgets.mem, "<span color='#04d9ff'>$2</span>", 2, "cpu0")


    local w3 = wibox.widget {
        markup = "",
        align = "center",
        widget = wibox.widget.textbox,
    }
    vicious.register(w3, vicious.widgets.fs, "<span color='#04d9ff'>${/ avail_gb}</span>", 2)


    local w4 = wibox.widget {
        markup = "",
        align = "center",
        widget = wibox.widget.textbox,
    }
    vicious.register(w4, vicious.widgets.fs, "<span color='#04d9ff'>${/ used_gb}</span>", 2)

    -- gears.timer {
    --     timeout = 5,
    --     autostart = true,
    --     call_now = false,
    --     callback = function()
    --         awful.spawn.easy_async_with_shell(
    --             "top -bn1 | grep 'Cpu' | awk '{print $2}'",
    --             function(stdout, stderr, reason, exit_code)
    --                 w1.markup = "<span color='#04d9ff'>"..stdout.."</span>"
    --             end
    --         )
    --     end
    -- }


    local wd1 = wibox.widget {
        {
            markup = "<span color='#ff035b'><b> </b></span>",
            font = "JetBrainsMono 16",
            widget = wibox.widget.textbox
        },
        w1,
        layout = wibox.layout.fixed.horizontal
    }
    local wd2 = wibox.widget {
        {
            font = "JetBrainsMono 16",
            markup = "<span color='#ff035b'><b> </b></span>",
            widget = wibox.widget.textbox
        },
        w2,
        layout = wibox.layout.fixed.horizontal
    }
    local wd3 = wibox.widget {
        {
            markup = "<span color='#ff035b'><b>󱐖 </b></span>",
            font = "JetBrainsMono 16",
            widget = wibox.widget.textbox
        },
        w3,
        layout = wibox.layout.fixed.horizontal
    }
    local wd4 = wibox.widget {
        {
            markup = "<span color='#ff035b'><b>󱐕 </b></span>",
            font = "JetBrainsMono 16",
            widget = wibox.widget.textbox
        },
        w4,
        layout = wibox.layout.fixed.horizontal
    }

    local box = wibox.widget {
        {
            {

                wd1,
                wd2,
                wd3,
                wd4,
                layout = wibox.layout.grid.horizontal,
                forced_num_rows = 2,
                expand = true,
                spacing = 0
            },
            widget = wibox.container.margin,
            margins = { top = 10, bottom = 10, left = 10, right = 10 }
        },

        widget = wibox.container.background,
        forced_height = 150,
        forced_width = 150,
        bg = "#00000099",
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 10)
        end
    }

    return box
end

return { sysperf = sysperf }
