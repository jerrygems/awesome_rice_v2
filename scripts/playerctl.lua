-- playerctl metadata | awk '/:title/{for (i=3; i<=NF; i++) printf "%s ", $i}'
local trackid     = io.popen("playerctl metadata | awk '/:trackid/{for (i=3; i<=NF; i++) printf \"%s \", $i}'", 'r')
:read("*a")
local length      = io.popen("playerctl metadata | awk '/:length/{for (i=3; i<=NF; i++) printf \"%s \", $i}'", 'r'):read(
"*a")
local artUrl      = io.popen("playerctl metadata | awk '/:artUrl/{for (i=3; i<=NF; i++) printf \"%s \", $i}'", 'r'):read(
"*a")
local album       = io.popen("playerctl metadata | awk '/:album/{for (i=3; i<=NF; i++) printf \"%s \", $i}'", 'r'):read(
"*a")
local albumArtist = io.popen("playerctl metadata | awk '/:albumArtist/{for (i=3; i<=NF; i++) printf \"%s \", $i}'", 'r')
:read("*a")
local artist      = io.popen("playerctl metadata | awk '/:artist/{for (i=3; i<=NF; i++) printf \"%s \", $i}'", 'r'):read(
"*a")
local autoRating  = io.popen("playerctl metadata | awk '/:autoRating/{for (i=3; i<=NF; i++) printf \"%s \", $i}'", 'r')
:read("*a")
local discNumber  = io.popen("playerctl metadata | awk '/:discNumber/{for (i=3; i<=NF; i++) printf \"%s \", $i}'", 'r')
:read("*a")
local title       = io.popen("playerctl metadata | awk '/:title/{for (i=3; i<=NF; i++) printf \"%s \", $i}'", 'r'):read(
"*a")
local trackNumber = io.popen("playerctl metadata | awk '/:trackNumber/{for (i=3; i<=NF; i++) printf \"%s \", $i}'", 'r')
:read("*a")
local url         = io.popen("playerctl metadata | awk '/:url/{for (i=3; i<=NF; i++) printf \"%s \", $i}'", 'r'):read(
"*a")


return {
    trackid = trackid,
    length = length,
    artUrl = artUrl,
    album = album,
    albumArtist = albumArtist,
    artist = artist,
    autoRating = autoRating,
    discNumber = discNumber,
    title = title,
    trackNumber = trackNumber,
    url = url,

}
