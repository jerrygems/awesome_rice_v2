local lgi = require("lgi")
local http = require("socket.http")
local ltn12 = require("ltn12")
local socket_url = require("socket.url")
local Gtk = lgi.require("Gtk", "3.0")



-- Storing the icon as local first
local function get_icon(url)
  local file_path = os.getenv("HOME") .. "/.config/awesome/dust/img/"

  local success, err_msg, err_code = os.execute('mkdir -p "' .. file_path .. '" > /dev/null 2>&1')

  if err_code ~= 0 then
    print("aw man failed to create the directory " .. err_code)
    if err_msg then
      print("Error message: " .. err_msg)
    end
  end


  local parsed_url = socket_url.parse(url)
  if parsed_url then
    local host = parsed_url.host
    local scheme = parsed_url.scheme

    local unique_name = "icon_" .. os.time() .. ".ico"
    local img_path = os.getenv("HOME") .. "/.config/awesome/dust/img/" .. unique_name

    local resp, status = http.request {

      url = scheme .. "://" .. host .. "/favicon.ico",
      sink = ltn12.sink.file(io.open(img_path, "wb")) }
    if status == 200 then
      print("image save successfully" .. unique_name)
    else
      print("failed to save the icon" .. status)
    end
  end
end

--


Gtk.init()

local window = Gtk.Window {
  on_destroy = Gtk.main_quit,
  default_width = 500,
  default_height = 200,
  resizable=false
}

local notebook = Gtk.Notebook {
  show_tabs = true
}

local stack1 = Gtk.Stack {}
local stack2 = Gtk.Stack {}
local stack3 = Gtk.Stack {}
-- first stack code

local l1 = Gtk.Label {
  name="icon",
  label = ""
}
local l2 = Gtk.Label {
  name="headin",
  label = "Create Favourite"
}
local entry_box = Gtk.Entry {
  name = "inpt",
  height_request = 50,
  placeholder_text = "format is this {Name::Link}"
}

local r1 = Gtk.Box {
  name = "s1r1",
  orientation = Gtk.Orientation.VERTICAL
}
r1:pack_start(l1, false, true, 0)
r1:pack_start(l2, true, true, 0)


local r2 = Gtk.Box {
  name = "s1r2",
  orientation = Gtk.Orientation.VERTICAL
}
r2:pack_start(entry_box, true, true, 0)


local box1 = Gtk.Box {
  name = "box1",
  orientation = Gtk.Orientation.VERTICAL
}
box1:pack_start(r1, true, true, 0)
box1:pack_start(r2, true, true, 0)

-- second stack code
local s2_l1 = Gtk.Label {
  name="icon2",
  label = "󰌾"
}
local s2_l2 = Gtk.Label {
  name="h1",
  label = "Hash It Up D:-)"
}
local s2_l3 = Gtk.Label {
  name="h4",
  label = "MD5:Text will be here"
}
local s2_entry_box = Gtk.Entry {
  name = "inpt2",
  height_request = 50,
  placeholder_text = "format {MD5::Text_Here}"
}

local s2_r1 = Gtk.Box {
  name = "s1r1",
  orientation = Gtk.Orientation.VERTICAL
}
s2_r1:pack_start(s2_l1, false, true, 0)
s2_r1:pack_start(s2_l2, true, true, 0)
s2_r1:pack_start(s2_l3, true, true, 0)


local s2_r2 = Gtk.Box {
  name = "s1r2",
  orientation = Gtk.Orientation.VERTICAL
}
s2_r2:pack_start(s2_entry_box, true, true, 0)

local box2 = Gtk.Box {
  name = "box2",
  orientation = Gtk.Orientation.VERTICAL
}
box2:pack_start(s2_r1,true,true,0)
box2:pack_start(s2_r2,true,true,0)

-- third stack code
local s3_l1 = Gtk.Label {
  name="icon3",
  label = ""
}
local s3_l2 = Gtk.Label {
  name="h1",
  label = "Try Decode Hash"
}
local s3_l3 = Gtk.Label {
  name="h4",
  label = "MD5:Hash will be here"
}
local s3_entry_box = Gtk.Entry {
  name = "inpt3",
  height_request = 50,
  placeholder_text = "format {MD5::Hash_Here}"
}

local s3_r1 = Gtk.Box {
  name = "s1r1",
  orientation = Gtk.Orientation.VERTICAL
}
s3_r1:pack_start(s3_l1, false, true, 0)
s3_r1:pack_start(s3_l2, true, true, 0)
s3_r1:pack_start(s3_l3, true, true, 0)


local s3_r2 = Gtk.Box {
  name = "s1r2",
  orientation = Gtk.Orientation.VERTICAL
}
s3_r2:pack_start(s3_entry_box, true, true, 0)

local box3 = Gtk.Box {
  name = "box3",
  orientation = Gtk.Orientation.VERTICAL
}

box3:pack_start(s3_r1,true,true,0)
box3:pack_start(s3_r2,true,true,0)



stack1:add_titled(box1, "page1", "Add Favorites")
stack2:add_titled(box2, "page2", "Hash It Up")
stack3:add_titled(box3, "page3", "Decoder")


notebook:append_page(stack1, Gtk.Label { label = "Page 1" })
notebook:append_page(stack2, Gtk.Label { label = "Page 2" })
notebook:append_page(stack3, Gtk.Label { label = "Page 3" })

window:add(notebook)

local provider = Gtk.CssProvider()
local file = lgi.Gio.File.new_for_path("./style.css") -- Replace with the actual path to your CSS file
provider:load_from_file(file)

local screen = window:get_screen()
Gtk.StyleContext.add_provider_for_screen(screen, provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION)
window:show_all()
Gtk.main()
