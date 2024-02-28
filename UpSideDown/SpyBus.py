import dbus

def get_current_audio_info():
    bus = dbus.SessionBus()
    spotify_bus_name = "org.mpris.MediaPlayer2.spotify"
    spotify_object_path = "/org/mpris/MediaPlayer2"
    spotify_interface = "org.freedesktop.DBus.Properties"

    try:
        spotify_player = bus.get_object(spotify_bus_name, spotify_object_path)
        props_interface = dbus.Interface(spotify_player, spotify_interface)
        metadata = props_interface.Get("org.mpris.MediaPlayer2.Player", "Metadata")
        
        # Extract relevant information from the metadata
        title = metadata.get("xesam:title", "Unknown Title")
        artist = metadata.get("xesam:artist", ["Unknown Artist"])[0]
        album = metadata.get("xesam:album", "Unknown Album")

        return f"Currently playing: {title} by {artist} from the album {album}"
    except dbus.exceptions.DBusException:
        return "No audio currently playing"

if __name__ == "__main__":
    print(get_current_audio_info())
