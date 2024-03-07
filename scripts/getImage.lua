local socket_url = require("socket.url")
local naughty = require("naughty")
local awful = require("awful")


-- Storing the icon as local first
local path = "/.config/awesome/dust/waste/"
local home_dir = os.getenv("HOME")


local function pathGen(file_path) -- if path is not created then create it
    local success, err_msg, err_code = os.execute('mkdir -p "' .. file_path .. '" > /dev/null 2>&1')

    if err_code ~= 0 then
        print("aw man failed to create the directory " .. err_code)
        if err_msg then
            print("Error message: " .. err_msg)
        end
    end
end

local function get_icon(url,imgid,callback)
    local file_path = home_dir .. path
    pathGen(file_path)                       -- if file path doesn't exist

    local parsed_url = socket_url.parse(url) -- filtering for getting the domain name
    if parsed_url then
        local host = parsed_url.host         -- name of the host
        local scheme = parsed_url.scheme     -- protocol that the host uses

        local unique_name = imgid .. os.time() .. ".ico"
        local img_path = os.getenv("HOME") .. path .. unique_name
        awful.spawn.easy_async("bash -c 'curl -o " .. img_path .. " -L " .. scheme .. "://" .. host .. "/favicon.ico'; sleep 1",
            function()
                if img_path then
                    callback(img_path)
                else
                    callback(os.getenv("HOME") .. "/.config/awesome/icons/question.svg")
                end
            end)
    end
end

-- without with specific_names
local function get_image(url, path, filename)
    os.execute("wget " .. url .. "-O" .. path .. "/" .. filename .. "")
end

return {
    get_icon = get_icon,
    get_image = get_image
}
