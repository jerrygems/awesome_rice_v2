local fetchman = require("fetchman")
-- Notification library
local naughty = require("naughty")
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
require("awful.autofocus")
local beautiful = require("beautiful")
-- local menubar = require("menubar")
-- local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
local keybindings = require("keybindings")
local titlebar = require("titlebar")
-- popups here
local infoBox = require("popups.infoBox")
--config
local config = require("confs.config").vars
local bars = require("bars.bars")
-- i know according to you it's unused
local notif = require("notifications.notifCenter")
local home_dir = os.getenv("HOME")



if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops! Jerry, errors during startup!",
        text = awesome.startup_errors
    })
end
-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        -- Make sure we don't go into an endless error loop
        if in_error then
            return
        end
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Oops! an error occurred!",
            text = tostring(err)
        })
        in_error = false
    end)
end

beautiful.useless_gap = config.useless_gap

-- default terminal editor
terminal = config.user.term
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor

awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.max,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw
}



-- {{{ Mouse bindings
root.buttons(gears.table.join(awful.button({}, 3, function()
    awful.mouse.client.resize(c)
end), awful.button({}, 4, awful.tag.viewnext), awful.button({}, 5, awful.tag.viewprev)))
-- }}}

-- Set keys
root.keys(keybindings.globalkeys)
-- }}}

client.connect_signal("request::titlebars", function(c)
    titlebar(c)
end)
-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    {
        rule = {},
        properties = {
            titlebars_enabled = config.user.titlebars_enabled,
            border_width = config.def.client_border_width,
            border_color = config.def.client_border_color,
            focus = awful.client.focus.filter,
            raise = true,
            keys = keybindings.clientkeys,
            buttons = keybindings.clientbuttons,
            screen = awful.screen.preferred,
            -- placement = awful.placement.no_overlap + awful.placement.no_offscreen
            placement = nil
        }
    },
    {
        rule = { class = "Firefox-esr" },
        properties = { tag = "5", screen = 1 }
    },
    {
        rule = { class = "obsidian" },
        properties = { tag = "4", screen = 1 }
    },
    {
        rule = { class = "discord" },
        properties = { tag = "9", screen = 1 }
    },
    {
        rule = { class = "Spotify" },
        properties = { tag = "8", screen = 1 }
    }

}
-- }}}

-- require("snap.snap")
-- bars stuff will be from here
-- awful.mouse.snap.edge_enabled = false

local function set_wallpaper(s)
    local wallpaper = config.user.wall[config.user.wall_index]
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
end
do
    set_wallpaper(s)
end
-- screen.connect_signal("property::geometry", set_wallpaper) -- it's time consuming
awful.screen.connect_for_each_screen(function(s)
    root.keys(gears.table.join(
        root.keys(),
        awful.key({ modkey }, "w", function()
            config.user.wall_index = (config.user.wall_index % #config.user.wall) + 1
            naughty.notification({ title = "Wallpaper Changed", text = "Was it really bad huh?      " })
            set_wallpaper(s)
        end),
        awful.key({ modkey, "Shift" }, "w", function()
            config.user.wall_index = (config.user.wall_index % #config.user.wall) - 1
            naughty.notification({ title = "Wallpaper Changed", text = "Oh, So you liked this one, hmmm..." })
            set_wallpaper(s)
        end)
    ))

    awful.tag.add("1", { layout = awful.layout.suit.floating, screen = s, selected = true, })
    awful.tag.add("2", { layout = awful.layout.suit.floating, screen = s, })
    awful.tag.add("3", { layout = awful.layout.suit.tile.bottom, screen = s, })
    awful.tag.add("4", { layout = awful.layout.suit.tile, screen = s, })
    awful.tag.add("5", { layout = awful.layout.suit.floating, screen = s, })
    awful.tag.add("6", { layout = awful.layout.suit.tile, screen = s, })
    awful.tag.add("7", { layout = awful.layout.suit.tile, screen = s, })
    awful.tag.add("8", { layout = awful.layout.suit.max, screen = s, })
    awful.tag.add("9", { layout = awful.layout.suit.max, screen = s, })

    s.mypromptbox = awful.widget.prompt()
end)

-- wibars applied
bars.create()

naughty.config.defaults.ontop = config.notifs.ontop
naughty.config.defaults.screen = awful.screen.focused()
naughty.config.defaults.timeout = config.notifs.timeout
naughty.config.defaults.position = config.notifs.position
naughty.notification({
    image = gears.color.recolor_image(home_dir .. "/" .. config.startup_message_image,"#ffffff00"),
    title = config.startup_message_title,
    text = config.startup_message
})
awful.screen.connect_for_each_screen(function(s)
    gears.timer {
        timeout   = 0.5,
        autostart = true,
        callback  = function()
            -- if collectgarbage("count") > 100 then
            -- naughty.notification({text=""..tostring(collectgarbage('count'))})
            collectgarbage("collect")
            -- end
        end
    }

    if s.index == 1 then
        local IB = nil
        root.keys(gears.table.join(root.keys(), awful.key({ modkey, "Shift" }, "i", function()
            if IB == nil then
                IB = infoBox.infoBox(
                    config.pop_infobox.width,
                    config.pop_infobox.height,
                    config.pop_infobox.posx,
                    config.pop_infobox.posy,
                    s
                )
                IB.visible = true
            else
                IB.visible = not IB.visible

                pcall(function()
                    IB.destroy()
                end)
            end
        end)))


        -- require("personal_widgets.stat_board").git_stats(900,1800,60,120,s)
        -- require("stuff.AiChat").AiChat(config.pop_aichat.width, config.pop_aichat.height, config.pop_aichat.posx,
        -- config.pop_aichat.posy, config.pop_aichat.bg, s)    -- AiChat(w,h,posx,posy,screen)
        -- require("popups.Quotes").Quotes(config.pop_quotes.width, config.pop_quotes.height, config.pop_quotes.posx,
        -- config.pop_quotes.posy, config.pop_quotes.quote, s) -- Quotes(w,h,posx,posy,quote_text,screen)
        -- require("extra_widgets.mrs_minute").mrs_minute(s, 300, 300, 1600, 60)
    end
end)
