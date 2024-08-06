local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local bars = require("bars.bars")
local taglist = require("bars.VBar.taglist")
local tools = require("bars.VBar.toolBox")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
local keybindings = require("keybindings")
local titlebar = require("titlebar")
local tag_and_task_btn = require("tag_and_task_btn")
-- local taglist = require("bars.VBar.taglist")
local favs = require("bars.VBar.favorites")
-- local tools = require("bars.VBar.toolBox")
local task = require("bars.HBar.tasklist")
local activity = require("bars.HBar.activity")
local gizmo = require("bars.HBar.gizmo")
local systray = require("systray.systray")
local integrate = require("bars.integrations.integrations")

-- popups here
local infoBox = require("popups.infoBox")

-- drawers
local shutdrawer = require("drawers.centerDrawer")
local switches = require("drawers.switchDrawer")

-- notificationcenter
local notifCenter = require("notifications.notifCenter")
local bottomBar = require("bars.Bbar.Bbar")
-- extra stuff

--config
local config = require("confs.config").vars
local bars = require("bars.bars")


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
            title = "Oops, an error happened!",
            text = tostring(err)
        })
        in_error = false
    end)
end

beautiful.useless_gap = 5

-- default terminal editor
terminal = config.def.term
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

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = config.def.wall
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)


-- {{{ Mouse bindings
root.buttons(gears.table.join(awful.button({}, 3, function()
    awful.mouse.client.resize(c)
end), awful.button({}, 4, awful.tag.viewnext), awful.button({}, 5, awful.tag.viewprev)))
-- }}}

-- Set keys
root.keys(keybindings.globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    {
        rule = {},
        properties = {
            border_width = config.def.client_border_width,
            border_color = config.def.client_border_color,
            focus = awful.client.focus.filter,
            raise = true,
            keys = keybindings.clientkeys,
            buttons = keybindings.clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen
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

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- bars stuff will be from here

awful.screen.connect_for_each_screen(function(s)
    set_wallpaper(s)

    awful.tag.add("1", { layout = awful.layout.suit.spiral.dwindle, screen = s, selected = true, })
    awful.tag.add("2", { layout = awful.layout.suit.corner.nw, screen = s, })
    awful.tag.add("3", { layout = awful.layout.suit.tile.bottom, screen = s, })
    awful.tag.add("4", { layout = awful.layout.suit.tile, screen = s, })
    awful.tag.add("5", { layout = awful.layout.suit.floating, screen = s, })
    awful.tag.add("6", { layout = awful.layout.suit.tile, screen = s, })
    awful.tag.add("7", { layout = awful.layout.suit.tile, screen = s, })
    awful.tag.add("8", { layout = awful.layout.suit.max, screen = s, })
    awful.tag.add("9", { layout = awful.layout.suit.max, screen = s, })

    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(awful.button({}, 1, function()
        awful.layout.inc(1)
    end), awful.button({}, 3, function()
        awful.layout.inc(-1)
    end), awful.button({}, 4, function()
        awful.layout.inc(1)
    end), awful.button({}, 5, function()
        awful.layout.inc(-1)
    end)))
end)



bars.create()


beautiful.notification_font = config.notifs.font
beautiful.notification_bg = config.notifs.bg
beautiful.notification_fg = config.notifs.fg
naughty.config.defaults.ontop = config.notifs.ontop
naughty.config.defaults.screen = awful.screen.focused()
naughty.config.defaults.timeout = config.notifs.timeout
naughty.config.defaults.position = config.notifs.position
naughty.connect_signal("request::display", function(n)
    require("notifications.notifMain").notifMain(n)
end)
naughty.notification({
    title = config.startup_message
})

shutdrawer().visible = config.def.shutdrawer_visibility

awful.screen.connect_for_each_screen(function(s)
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
        -- require("stuff.AiChat").AiChat(config.pop_aichat.width, config.pop_aichat.height, config.pop_aichat.posx,
        -- config.pop_aichat.posy, config.pop_aichat.bg, s)    -- AiChat(w,h,posx,posy,screen)
        require("popups.Quotes").Quotes(config.pop_quotes.width, config.pop_quotes.height, config.pop_quotes.posx,
            config.pop_quotes.posy, config.pop_quotes.quote, s) -- Quotes(w,h,posx,posy,quote_text,screen)
    end
end)
