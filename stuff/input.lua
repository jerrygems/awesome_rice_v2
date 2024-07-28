local wibox = require("wibox")
local naughty = require("naughty")
local awful = require("awful")
local gears = require("gears")

local inpt = wibox.widget.textbox
inpt.text = "Type Here"
-- inpt.font="BlackOpsOne 18"

local input = wibox.widget {
  widget = wibox.widget.textbox,
  markup = "<span color='#ffff00' font='KodeMono 18'>" .. inpt.text .. "</span>",
  align = "center",
  valign = "center"
}
local function update_text()
  input.markup = "<span color='#ffff00' font='KodeMono 18'>" .. inpt.text .. "</span>"
end

local function inpbox(w, h, bg)
  local function get_input_text()
    return inpt.text
  end
  local inp = wibox.widget {
    {
      input,
      widget = wibox.container.margin,
      margins = { left = 5, top = 5, right = 5, bottom = 5 }
    },
    forced_width = w,
    forced_height = h,
    bg = bg,
    widget = wibox.container.background,
    shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 10)
    end
  }
  return {
    input_widget = inp,
    get_input_text = get_input_text
  }
end

input:connect_signal("button::press", function()
  awful.keygrabber.run(function(mod, key, event)
    if event == "press" then
      if key == "Return" then
        awful.keygrabber.stop()
        update_text()
        return false
      elseif key == "Escape" then
        -- input.text = ""
        awful.keygrabber.stop()
        update_text()
        return false
      elseif key == "BackSpace" then
        if mod[1] == "Control" then
          local pos = inpt.text:find("%s[^%s]*$")
          if pos then
            inpt.text = inpt.text:sub(1, pos - 1)
          else
            inpt.text = ""
          end
        else
          inpt.text = inpt.text:sub(1, -2)
        end
        update_text()
      elseif #key == 1 then
        inpt.text = inpt.text .. key
        update_text()
      end
    end
    return true
  end)
end)

return {
  inpbox = inpbox
}
