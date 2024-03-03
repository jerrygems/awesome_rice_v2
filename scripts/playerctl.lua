local naughty  = require("naughty")
local gears    = require("gears")
-- playerctl metadata | awk '/:title/{for (i=3; i<=NF; i++) printf "%s ", $i}'

local metadata = {
    trackid     = io.popen("playerctl metadata | awk '/:trackid/{for (i=3; i<=NF; i++) printf \"%s \", $i}'", 'r')
        :read("*a"),
    length      = io.popen("playerctl metadata | awk '/:length/{for (i=3; i<=NF; i++) printf \"%s \", $i}'", 'r')
        :read(
            "*a"),
    artUrl      = io.popen("playerctl metadata | awk '/:artUrl/{for (i=3; i<=NF; i++) printf \"%s \", $i}'", 'r')
        :read(
            "*a"),
    album       = io.popen("playerctl metadata | awk '/:album/{for (i=3; i<=NF; i++) printf \"%s \", $i}'", 'r')
        :read(
            "*a"),
    albumArtist = io.popen("playerctl metadata | awk '/:albumArtist/{for (i=3; i<=NF; i++) printf \"%s \", $i}'",
            'r')
        :read("*a"),
    artist      = io.popen("playerctl metadata | awk '/:artist/{for (i=3; i<=NF; i++) printf \"%s \", $i}'", 'r')
        :read(
            "*a"),
    autoRating  = io.popen("playerctl metadata | awk '/:autoRating/{for (i=3; i<=NF; i++) printf \"%s \", $i}'",
            'r')
        :read("*a"),
    discNumber  = io.popen("playerctl metadata | awk '/:discNumber/{for (i=3; i<=NF; i++) printf \"%s \", $i}'",
            'r')
        :read("*a"),
    title       = io.popen("playerctl metadata | awk '/:title/{for (i=3; i<=NF; i++) printf \"%s \", $i}'", 'r')
        :read(
            "*a"),
    trackNumber = io.popen("playerctl metadata | awk '/:trackNumber/{for (i=3; i<=NF; i++) printf \"%s \", $i}'",
            'r')
        :read("*a"),
    url         = io.popen("playerctl metadata | awk '/:url/{for (i=3; i<=NF; i++) printf \"%s \", $i}'", 'r')
        :read(
            "*a")
}

local function update_it()
    metadata.trackid     = io.popen("playerctl metadata | awk '/:trackid/{for (i=3; i<=NF; i++) printf \"%s \", $i}'",
            'r')
        :read("*a")
    metadata.length      = io.popen("playerctl metadata | awk '/:length/{for (i=3; i<=NF; i++) printf \"%s \", $i}'", 'r')
        :read(
            "*a")
    metadata.artUrl      = io.popen("playerctl metadata | awk '/:artUrl/{for (i=3; i<=NF; i++) printf \"%s \", $i}'", 'r')
        :read(
            "*a")
    metadata.album       = io.popen("playerctl metadata | awk '/:album/{for (i=3; i<=NF; i++) printf \"%s \", $i}'", 'r')
        :read(
            "*a")
    metadata.albumArtist = io.popen(
            "playerctl metadata | awk '/:albumArtist/{for (i=3; i<=NF; i++) printf \"%s \", $i}'",
            'r')
        :read("*a")
    metadata.artist      = io.popen("playerctl metadata | awk '/:artist/{for (i=3; i<=NF; i++) printf \"%s \", $i}'", 'r')
        :read(
            "*a")
    metadata.autoRating  = io.popen("playerctl metadata | awk '/:autoRating/{for (i=3; i<=NF; i++) printf \"%s \", $i}'",
            'r')
        :read("*a")
    metadata.discNumber  = io.popen("playerctl metadata | awk '/:discNumber/{for (i=3; i<=NF; i++) printf \"%s \", $i}'",
            'r')
        :read("*a")
    metadata.title       = io.popen("playerctl metadata | awk '/:title/{for (i=3; i<=NF; i++) printf \"%s \", $i}'", 'r')
        :read(
            "*a")
    metadata.trackNumber = io.popen(
            "playerctl metadata | awk '/:trackNumber/{for (i=3; i<=NF; i++) printf \"%s \", $i}'",
            'r')
        :read("*a")
    metadata.url         = io.popen("playerctl metadata | awk '/:url/{for (i=3; i<=NF; i++) printf \"%s \", $i}'", 'r')
        :read(
            "*a")
end



local metadata = {}
gears.timer {
    timeout = 1,
    autostart = true,
    call_now = true,
    callback = function()
        return metadata
    end

}

return metadata
