local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")
local hotkeys_popup = require("awful.hotkeys_popup")
local shutter = require("drawers.centerDrawer")

local shut = shutter()
modkey = "Mod4"

-- {{{ Key bindings
local globalkeys = gears.table.join(
    awful.key({ modkey, }, "Left", awful.tag.viewprev,
        { description = "view previous", group = "tag" }),
    awful.key({ modkey, }, "Right", awful.tag.viewnext,
        { description = "view next", group = "tag" }),
    awful.key({ modkey, }, "Escape", awful.tag.history.restore,
        { description = "go back", group = "tag" }),

    -- Layout manipulation
    awful.key({ modkey, }, "Tab",
        function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        { description = "go back", group = "client" }),

    -- Standard program
    awful.key({ modkey, }, "Return", function() awful.spawn.easy_async(terminal,function ()
        return nil
    end) end,
        { description = "open a terminal", group = "launcher" }),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
        { description = "reload awesome", group = "awesome" }),
    awful.key({ modkey, "Shift" }, "q", awesome.quit,
        { description = "quit awesome", group = "awesome" }),
    awful.key({ modkey, }, "t", function() awful.layout.inc(1) end,
        { description = "select next", group = "layout" }),
    awful.key({ modkey, "Shift" }, "t", function() awful.layout.set(awful.layout.layouts[1]) end,
        { description = "select previous", group = "layout" }),

    awful.key({ modkey }, "]",
        function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                c:emit_signal(
                    "request::activate", "key.unminimize", { raise = true }
                )
            end
        end,
        { description = "restore minimized", group = "client" }),

    -- Prompt
    awful.key({ modkey }, "r", function() awful.screen.focused().mypromptbox:run() end,
        { description = "run prompt", group = "launcher" }),


    awful.key({ modkey }, "d",
        function(c)
            awful.spawn.easy_async("rofi -show drun ",function ()
                return nil
            end)
        end,
        { description = "rofi", group = "client" }),
    awful.key({ modkey, "Shift" }, "d",
        function(c)
            awful.spawn.easy_async("rofi -show window ",function ()
                return nil
            end)
        end,
        { description = "rofi", group = "client" }),
    awful.key({ modkey }, "x",

        function(c)
            shut.visible = not shut.visible
        end,
        { description = "shutdown widget visibility", group = "client" }),
    awful.key({modkey},"h",
        function(c)
            awful.spawn.easy_async("playerctl position 10-",function ()
                return nil
            end)
        end,
    {description="music seek", group="client"}),
    awful.key({modkey},"j",
    function(c)
        awful.spawn.easy_async("playerctl previous",function ()
            return nil
        end)
    end,
    {description="music button", group="client"}),
    awful.key({modkey},"k",
    function(c)
        awful.spawn.easy_async("playerctl play-pause",function ()
            return nil
        end)
    end,
    {description="music button", group="client"}),
    awful.key({modkey},"l",
    function(c)
        awful.spawn.easy_async("playerctl next",function ()
            return nil
        end)
    end,
    {description="music button", group="client"}),
    awful.key({modkey},";",
        function(c)
            awful.spawn.easy_async("playerctl position 10+",function ()
                return nil
            end)
        end,
    {description="music seek", group="client"}),
    awful.key({modkey, "Shift" }, "Up",
        function(c)
            awful.spawn.easy_async("pulsemixer --change-volume +10", function ()
                return nil
            end)
        end,
    {description="music volume", group="client"}),
    awful.key({modkey, "Shift" }, "Down",
        function(c)
            awful.spawn.easy_async("pulsemixer --change-volume -10",function ()
                return nil
            end)
        end,
    {description="music volume", group="client"})
)

local clientkeys = gears.table.join(
    awful.key({ modkey }, "[",
        function(c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end,
        { description = "minimize", group = "client" }),
    awful.key({ modkey, }, "f",
        function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        { description = "toggle fullscreen", group = "client" }),
    awful.key({ modkey, "Shift" }, "c", function(c) c:kill() end,
        { description = "close", group = "client" }),
    awful.key({ modkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end,
        { description = "move to master", group = "client" }),
    awful.key({ modkey, }, "o", function(c) c:move_to_screen() end,
        { description = "move to screen", group = "client" }),
    awful.key({ modkey,}, "`", function(c) c.ontop = not c.ontop end,
        { description = "toggle keep on top", group = "client" }),

    awful.key({ modkey, }, "m",
        function(c)
            c.maximized = not c.maximized
            c:raise()
        end,
        { description = "(un)maximize", group = "client" }),
    awful.key({ modkey, "Shift" }, "v",
        function(c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end,
        { description = "(un)maximize vertically", group = "client" }),
    awful.key({ modkey, "Shift" }, "h",
        function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end,
        { description = "(un)maximize horizontally", group = "client" })

)

for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            { description = "view tag #" .. i, group = "tag" }),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            { description = "toggle tag #" .. i, group = "tag" }),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            { description = "move focused client to tag #" .. i, group = "tag" }),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            { description = "toggle focused client on tag #" .. i, group = "tag" })
    )
end


local clientbuttons = gears.table.join(
    awful.button({}, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
    end),
    awful.button({ modkey }, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 2, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.resize(c)
    end)
)

return {
    globalkeys = globalkeys,
    clientkeys = clientkeys,
    clientbuttons = clientbuttons,
}
