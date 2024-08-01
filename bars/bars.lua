local gears = require("gears")
local awful = require("awful")
local config = require("confs.config").vars

local function funbars(s)
    local left = awful.wibar({
        position = "left",
        screen = s,
        type = "normal",
        width = s.geometry.width * (config.LB_width / 100),
        height = s.geometry.height * (config.LB_height / 100),
        visible = config.LB_visible,
        margins = {
            left = config.LB_MG_left,
            right = config.LB_MG_right
        },
        bg = config.LB_bg,
        fg = config.LB_fg,
        ontop = config.LB_ontop,
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, config.LB_radius)
        end
    })

    local top = awful.wibar({
        position = "top",
        screen = s,
        type = "normal",
        width = s.geometry.width * (config.TB_width / 100),
        height = s.geometry.height * (config.TB_height / 100),
        visible = config.TB_visible,
        margins = {
            top = config.TB_MG_top,
            bottom = config.TB_MG_bottom
        },
        bg = config.TB_bg,
        fg = config.TB_fg,
        ontop = config.TB_ontop,
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, config.TB_radius)
        end
    })

    local bottom = awful.wibar({
        position = "bottom",
        screen = s,
        type = "normal",
        width = s.geometry.width * (config.BB_width / 100),
        height = s.geometry.height * (config.BB_height / 100),
        visible = config.BB_visible,
        margins = {
            top = config.BB_MG_top,
            bottom = config.BB_MG_bottom,
        },
        bg = config.BB_bg,
        fg = config.BB_fg,
        ontop = config.BB_ontop,
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, config.BB_radius)
        end
    })

    local right = awful.wibar({
        position = "right",
        screen = s,
        type = "normal",
        width = s.geometry.width * (config.RB_width / 100),
        height = s.geometry.height * (config.RB_height / 100),
        visible = config.RB_visible,
        margins = {
            right = config.RB_MG_right,
            left = config.RB_MG_left
        },
        bg = config.RB_bg,
        fg = config.RB_fg,
        ontop = config.RB_ontop,
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, config.RB_radius)
        end
    })

    local toggle_bar = awful.key({ modkey, "Shift" }, "b", function()
        right.visible = not right.visible
        left.visible = not left.visible
        bottom.visible = not bottom.visible
        top.visible = not top.visible
    end)
    local basic_toggle = awful.key({ modkey }, "b", function()
        right.visible = not right.visible
        left.visible = not left.visible
        bottom.visible = not bottom.visible
    end)

    return {
        toggle_bar = toggle_bar,
        basic_toggle = basic_toggle,
        left = left,
        top = top,
        right = right,
        bottom = bottom
    }
end

return {
    funbars = funbars
}
