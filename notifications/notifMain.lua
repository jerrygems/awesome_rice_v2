local notifCenter = require("notifications.notifCenter")


local function notifMain(n)
    notifCenter(n)
end

return { notifMain = notifMain }
