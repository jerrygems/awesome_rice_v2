local http = require("socket.http")
local ltn12 = require("ltn12")
local socket_url = require("socket.url")


-- Storing the icon as local first
local function get_icon(url, path)
    local file_path = os.getenv("HOME") .. path

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
        local img_path = os.getenv("HOME") .. path .. unique_name

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

-- without with specific_names
local function get_image(url, path, filename)
    os.execute("wget " .. url .. "-O" .. path .. filename .. "")
end

return {
    get_icon = get_icon,
    get_image = get_image
}
