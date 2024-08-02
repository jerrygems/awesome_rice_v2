local beautiful = require("beautiful")
local username = os.getenv("USER") or os.getenv("USERNAME")

-- LB stands for left bar
-- RB stands for left bar
-- TB stands for left bar
-- BB stands for left bar
-- tag stands for taglist
-- task stands for tasklist
-- scut stands for shortcuts
-- bat for battery
-- ble for bluetooth
-- wifi for wifi
-- gizmo for widget box on top right
-- actvt for activity widget on top left
-- fnt for font
-- mx for max
-- df for default
-- mgs for margins
-- clr for color
local vars = {
    startup_message = "Let's Create Something osm",

    actvt_fnt = "KodeMono 10",
    actvt_fnt_clr = "#ff035b",
    actvt_bg = "#00000099",
    actvt_mg_left = 7,
    actvt_mg_right = 7,
    actvt_mg_top = 5,
    actvt_mg_bottom = 5,

    gizmo_iface_name = "wlp61s0", -- or it could wlan0 or if it doesn't work then just remove the widget accordingly
    gizmo_fnt = "JetBrainsMono 13",
    gizmo_txt_fnt_clr = "#04d9ff",
    gizmo_ic_fnt_clr = "#ff035b",
    gizmo_bg = "#00000099",
    gizmo_mgs = {
        top = 0,
        bottom = 0,
        left = 5,
        right = 5
    },
    gizmo_radius = 15,

    systray_bat_fnt = "JetBrainsMono 14",
    systray_bat_bg = "#000000",
    systray_bat_on_charge_bar_clr = "#999999",
    systray_bat_not_on_charge_bar_clr = "#ffffff",
    systray_bat_on_charge_symbol_clr = "#ffffffaa",
    systray_bat_txt_clr_when_below_25 = "#e3242b88",
    systray_bat_clr_when_below_25 = "#e3242b",
    systray_bat_low_battery_title = "Critical Battery Level",
    systray_bat_low_battery_txt = "Jerry connect your charger i'm gonna die soon",
    systray_bat_name = "BAT1",
    systray_bat_clr_behind_bar = "#000000",
    systray_bat_border_clr = "#ffffff",

    systray_ble_clr_on_disconnected = "#ffffff",
    systray_ble_clr_on_connected = "#00ffff",

    systray_wifi_iface_name = "wlp61s0", -- or it could be wlan0 but it may vary so just check which one you have
    systray_wifi_df_clr = "#ffffff",
    systray_wifi_margins = {
        top = 7,
        bottom = 3,
        left = 9,
        right = 9
    },
    -- wifi colors when signal >= -30
    systray_arc2_clr_c1 = "#ffffff",
    systray_arc1_clr_c1 = "#ffffff",
    systray_dot_clr_c1 = "#ffffff",
    -- signal >= -60 and signal < -30
    systray_arc2_clr_c2 = "#ffffff88",
    systray_arc1_clr_c2 = "#ffffff",
    systray_dot_clr_c2 = "#ffffff",
    -- signal >= -70 and signal < -60
    systray_arc2_clr_c3 = "#ffffff88",
    systray_arc1_clr_c3 = "#ffffff88",
    systray_dot_clr_c3 = "#ffffff",
    -- signal > -100 and signal < -70
    systray_arc2_clr_c4 = "#ffffff88",
    systray_arc1_clr_c4 = "#ffffff88",
    systray_dot_clr_c4 = "#ffffff88",
    -- else
    systray_arc2_clr_c5 = "#FD9346",
    systray_arc1_clr_c5 = "#FD7F2C",
    systray_dot_clr_c5 = "#FF6200",

    icons_df_clr_on_hover = "#ff035bff",

    tag_bg = "#00000099",
    tag_bg_empty = "#7FE5F022",
    tag_bg_occupied = "#ff035b88",
    tag_bg_focus = "#04d9ffff",
    tag_bg_urgent = "#ff3d74",
    tag_inner_radius = 20,
    tag_wrapper_radius = 5,
    tag_height = 30,
    tag_height_on_select = 15,

    btm_bar_txt_clr = "#ffffff",
    btm_bar_fnt = "KodeMono 12",
    btm_bar_cpu = "cpu0",

    shutbtns_txt_clr = "#ffffff",
    shutbtns_fnt = "Monoton 25",
    shutbtns_bg = "#00000044",
    shutbtns_mgs = {
        top = 10,
        bottom = 10,
        left = 10,
        right = 10
    },
    shutbtns_btns_clr = "#ffffffff",
    shutbtns_btns_clr_on_hover = "#ff035bff",


    -- left_bar
    -- LB -> left bar
    LB_width = 2.2, -- in %
    LB_height = 85, -- in %
    LB_MG_left = 5,
    LB_MG_right = 5,
    LB_bg = "#ffffff11",
    LB_fg = "#ffffffff",
    LB_radius = 8,
    LB_ontop = false,
    LB_visible = false,

    -- top_bar
    TB_width = 98,
    TB_height = 3.6,
    TB_MG_top = 3,
    TB_MG_bottom = 4,
    TB_bg = "#ffffff11",
    TB_fg = "#ffffffff",
    TB_ontop = false,
    TB_radius = 8,
    TB_visible = true,

    TB_task_bg = "#000000",
    TB_task_back_bg = "#00000055",
    TB_task_width = 230,
    TB_task_mx_width = 210,
    TB_task_df_mgs = {
        top = 0,
        bottom = 0,
        left = 5,
        right = 5
    },

    -- bottom_bar
    BB_width = 70,
    BB_height = 3.5,
    BB_MG_top = 3,
    BB_MG_bottom = 3,
    BB_bg = "#ffffff11",
    BB_fg = "#DC143Cff",
    BB_ontop = false,
    BB_visible = false,
    BB_radius = 8,

    -- right_bar
    RB_width = 2.2,
    RB_height = 85,
    RB_visible = false,
    RB_MG_right = 5,
    RB_MG_left = 5,
    RB_bg = "#ffffff11",
    RB_fg = "#ffffffff",
    RB_ontop = false,
    RB_radius = 8,


    -- defaults
    -- def -> default
    def = {
        term = "alacritty",
        wall = "~/Downloads/anime.png",
        client_border_width = 2,
        client_border_color = "#ff0000",
        shutdrawer_visibility = false,
    },

    -- popup_configs
    pop_infobox = {
        width = 22,
        height = 52,
        posx = 0.2,
        posy = 0.7,
        radius = 10,
        popup_bg = "#00000000",
        popup_border_width = 0,
        popup_border_color = "#00000000",
        container_bg = "#22222277",
    },
    music_box = {
        
    },
    pop_aichat = {
        width = 20,
        height = 45,
        posx = 3.6,
        posy = 0.5,
        bg = "#00000066",
    },
    pop_quotes = {
        width = 30,
        height = 40,
        posx = 1.1,
        posy = 1.4,
        quote = [[
            ...But, then again, isn't it all the same? Our senses just mediocre inputs to our brain? Sure, we rely on them, trust they accurately portray the real world around us, but what if the haunting truth is they can't? That what we perceive isn't the real world at all, but just our mind's best guess? That all we really have is a garbled reality, a truly fuzzy picture we will never make out?
                ]]
    },

    -- notifications stuff here
    notifs = {
        position = "bottom_right",
        bg = "#000000aa",
        fg = "#fc035a",
        font = "JetBrainsMono 15",
        ontop = true,
        timeout = 8,
    },
    notif_bg_color = "#00000000",
    notif_title_fnt = "KodeMono 14",
    notif_message_fnt = "KodeMono 9",
    notif_title_clr = "#ffffff",
    notif_message_clr = "#ffffff",
    notif_width = 340,
}

return {
    vars = vars
}
