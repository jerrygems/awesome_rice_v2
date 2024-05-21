local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
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
local taglist = require("bars.VBar.taglist")
local favs = require("bars.VBar.favorites")
local tools = require("bars.VBar.toolBox")
local task = require("bars.HBar.tasklist")
local activity = require("bars.HBar.activity")
local gizmo = require("bars.HBar.gizmo")
local systray = require("systray.systray")
local integrate = require("bars.integrations.integrations")

-- popups here
local infoBox = require("popups.infoBox")

-- drawers
local shutdrawer = require("drawers.centerDrawer")
local notifdrawer = require("drawers.notifDrawer")

-- notificationcenter
local notifCenter = require("notifications.notifCenter")
local bottomBar = require("bars.Bbar.Bbar")

if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
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
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
-- beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.useless_gap = 3
-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- modkey = "Mod4"

awful.layout.layouts = {awful.layout.suit.floating, --
awful.layout.suit.tile, awful.layout.suit.tile.left, awful.layout.suit.tile.bottom, awful.layout.suit.tile.top, --
awful.layout.suit.fair, awful.layout.suit.fair.horizontal, --
awful.layout.suit.spiral, awful.layout.suit.max, awful.layout.suit.magnifier, --
awful.layout.suit.corner.nw}

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
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
awful.rules.rules = {{
    rule = {},
    properties = {
        border_width = 2,
        border_color = "#00ffff",
        focus = awful.client.focus.filter,
        raise = true,
        keys = keybindings.clientkeys,
        buttons = keybindings.clientbuttons,
        screen = awful.screen.preferred,
        placement = awful.placement.no_overlap + awful.placement.no_offscreen
    }
}, -- Add titlebars to normal clients and dialogs
{
    rule_any = {
        type = {"normal", "dialog"}
    },
    properties = {
        titlebars_enabled = true
    }
}}
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

-- client.connect_signal("request::titlebars", function(c)
--    titlebar(c)
-- end)

-- -- so here we can define the events of mouse
-- client.connect_signal("mouse::enter", function(c)
--     c:emit_signal("request::activate", "mouse_enter", {
--         raise = false
--     })
-- end)

-- client.connect_signal("focus", function(c)
--     c.border_color = "#00ffff"
-- end)
-- client.connect_signal("unfocus", function(c)
--     c.border_color = beautiful.border_normal
-- end)

-- bars stuff will be from here

awful.screen.connect_for_each_screen(function(s)
    -- set_wallpaper(s)

    awful.tag({"1", "2", "3", "4", "5", "6", "7", "8", "9"}, s, awful.layout.layouts[1])

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

    -- Create a taglist widget
    -- s.mytaglist = awful.widget.taglist {
    --     screen = s,
    --     filter = awful.widget.taglist.filter.all,
    --     buttons = tag_and_task_btn.taglist_buttons
    -- }
    -- Create a tasklist widget
    -- s.mytasklist = awful.widget.tasklist {
    --     screen = s,
    --     filter = awful.widget.tasklist.filter.currenttags,
    --     buttons = tag_and_task_btn.tasklist_buttons
    -- }
    -- Create the wibox
    -- s.mywibox = awful.wibar({
    --     position = "top",
    --     screen = s
    -- })

    -- Add widgets to the wibox
    -- s.mywibox:setup {
    --     layout = wibox.layout.align.horizontal,
    --     {
    --         layout = wibox.layout.fixed.horizontal,
    --         s.mytaglist,
    --         s.mypromptbox
    --     },
    --     s.mytasklist,
    --     {
    --         layout = wibox.layout.fixed.horizontal,
    --         wibox.widget.systray(),
    --         s.mylayoutbox
    --     }
    -- }
end)

awful.screen.connect_for_each_screen(function(s)

    set_wallpaper(s)
    s.left_bar = awful.wibar({
        position = "left",
        screen = s,
        type = "normal",
        width = s.geometry.width * (2 / 100),
        height = s.geometry.height * (85 / 100),
        visible = true,
        margins = {
            left = 5,
            right = 5
        },
        bg = "#ffffff11",
        fg = "#ffffffff",
        ontop = false,
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 8)
        end
    })

    s.left_bar:setup{

        layout = wibox.layout.align.vertical,
        taglist.taglist_fun(s),
        tools.toolBoxBar(s)
    }

    -- -- --
    s.top_bar = awful.wibar({
        position = "top",
        screen = s,
        type = "normal",
        width = s.geometry.width * (98 / 100),
        height = s.geometry.height * (3.5 / 100),
        visible = true,
        margins = {
            top = 3,
            bottom = 4
        },
        -- bg = "#00000077",
        bg = "#ffffff11",
        fg = "#ffffffff",
        ontop = false,
        -- border_width = 4,
        -- border_color = "#000000",
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 8)
        end
    })

    s.top_bar:setup{
        layout = wibox.layout.align.horizontal,

        {
            task.tasklistBar(s),
            activity.activityBar(s),
            widget = wibox.container.place,
            layout = wibox.layout.fixed.horizontal
        },
        wibox.container.place(gizmo.gizmoZ(s), "right", "center"),
        wibox.container.place(systray.systray(s), "right", "center")

    }

    s.bottom_bar = awful.wibar({
        position = "bottom",
        screen = s,
        type = "normal",
        width = s.geometry.width * (70 / 100),
        height = s.geometry.height * (3.5 / 100),
        visible = true,
        margins = {
            top = 3
        },
        bg = "#ffffff11",
        -- bg = "#00000000",
        fg = "#ffffffff",
        ontop = false,
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 8)
        end
    })

    s.bottom_bar:setup{
        layout = wibox.layout.align.horizontal,
        bottomBar.Bbar(s)

    }

    s.integration_bar = awful.wibar({
        position = "right",
        screen = s,
        type = "normal",
        width = s.geometry.width * (2 / 100),
        height = s.geometry.height * (85 / 100),
        visible = true,
        -- x = 5,
        margins = {
            right = 5,
            left = 5
        },
        -- bg = "#00000077",
        bg = "#ffffff11",
        fg = "#ffffffff",
        ontop = false,
        -- border_width = 4,
        -- border_color = "#000000",
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 8)
        end
    })

    s.integration_bar:setup{
        integrate.integrations(s),
        favs.favourites(s),
        layout = wibox.layout.flex.vertical

    }

    local toggle_bar = awful.key({modkey, "Shift"}, "b", function()
        s.integration_bar.visible = not s.integration_bar.visible
        s.left_bar.visible = not s.left_bar.visible
        s.bottom_bar.visible = not s.bottom_bar.visible
        s.top_bar.visible = not s.top_bar.visible
    end, {
        description = "Toggle integration bar",
        group = "custom"
    })
    local basic_toggle = awful.key({modkey, "Shift"}, "b", function()
        s.integration_bar.visible = not s.integration_bar.visible
        s.left_bar.visible = not s.left_bar.visible
        s.bottom_bar.visible = not s.bottom_bar.visible
    end, {
        description = "Toggle integration bar",
        group = "custom"
    })

    root.keys(gears.table.join(root.keys(), toggle_bar, basic_toggle))

end)

beautiful.notification_font = "JetBrainsMono 15"
naughty.config.defaults.ontop = true
naughty.config.defaults.screen = awful.screen.focused()
naughty.config.defaults.timeout = 8
naughty.config.defaults.position = "bottom_right"
naughty.connect_signal("request::display", function(n)
    notifCenter(n)
    -- notifdrawer(n)
end)
naughty.notification({
    title = "Let's Create Something osm"
})

--[[
    KodeMono
    MadimiOne
    Micro5
    Monoton
    OleoScript
    PermanentMarker
    PlayfairDisplay
    RubikGlitchPop
    Satisfy
    Sixtyfour
    Caveat
    BlackOpsOne
    ArchivoBlack
    ]]
shutdrawer().visible = false
awful.screen.connect_for_each_screen(function(s)
    infoBox.infoBox(s)
    shutdrawer()

    require("popups.Quotes").Quotes()
end)

