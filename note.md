## https://developer-old.gnome.org/gio/stable/index.html

<!-- bluetoothctl info | tail -n 1 | awk '{print $4}' | tr -d  '()' -->
```Button 1: Primary mouse button (usually left-click)
Button 2: Middle mouse button (often used for scrolling)
Button 3: Right mouse button (usually right-click)
Button 4: Mouse wheel scroll up
Button 5: Mouse wheel scroll down
```
```lua
    awful.layout.inc(1) increments the layout when Button 1 (left-click) is pressed.
    awful.layout.inc(-1) decrements the layout when Button 3 (right-click) is pressed.
    awful.layout.inc(1) increments the layout when Button 4 (scroll up) is triggered.
    awful.layout.inc(-1) decrements the layout when Button 5 (scroll down) is triggered.
```

## Signals 
```
Tag Signals:

    tag::history::update: Emits when tag history changes (e.g., switching tags).
    property::selected: Indicates the change in the selected state of a tag.
    property::activated: Emits when a tag is activated (i.e., becomes the active tag).

Client (Window) Signals:

    property::name: Emits when the name of a client changes.
    request::activate: Triggered when a client requests activation.
    request::unmanage: Emits when a client window is about to be unmanaged.

Screen Signals:

    list::add: Emits when a new screen is added.
    removed: Emits when a screen is removed.
    property::geometry: Emits when the screen's geometry changes.

Mouse Signals:

    button::press: Triggered when a mouse button is pressed.
    button::release: Emits when a mouse button is released.
    mouse::enter: Indicates the mouse entering a widget/container.
    mouse::leave: Emits when the mouse leaves a widget/container.

Keyboard Signals:

    keygrabber::pressed: Emits when a key is pressed.
    keygrabber::released: Triggered when a key grab is released.

Layout Signals:

    property::selected_layout: Emits when the selected layout of a screen changes.
    mouse::screen: Indicates the change of the screen by mouse interaction.

Misc Signals:

    spawn::completed: Triggered when a spawn process is completed.
    exit::signal: Emits when a signal is received by a process.
    tag_preview::update: Used in the tag preview module when updating tag previews.
```
