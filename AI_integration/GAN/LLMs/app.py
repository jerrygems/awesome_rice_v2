import gi
gi.require_version("Gtk", "3.0")
from gi.repository import Gtk,Gdk
from stacks.stack1 import FirstStack
from stacks.stack2 import SecondStack
from stacks.stack3 import ThirdStack

class MyWindow(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="ELLIOT VOICE ASISTANT")
        self.set_default_size(400, 300)
        self.set_border_width(10)

        stack = Gtk.Stack()
        stack.set_transition_type(Gtk.StackTransitionType.SLIDE_LEFT_RIGHT)
        stack.set_transition_duration(1000)

        first_screen = FirstStack()
        second_screen = SecondStack()
        third_screen = ThirdStack()

        stack.add_named(third_screen, "third_screen")
        stack.add_named(first_screen, "first_screen")
        stack.add_named(second_screen, "second_screen")

        stack_switcher = Gtk.StackSwitcher()
        stack_switcher.set_stack(stack)

        vbox = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=6)
        vbox.pack_start(stack_switcher, False, False, 0)
        vbox.pack_start(stack, True, True, 0)

        self.add(vbox)

win = MyWindow()
win.connect("destroy", Gtk.main_quit)
win.show_all()

provider = Gtk.CssProvider()
provider.load_from_path("../style.css")
screen = Gdk.Screen.get_default()
context = Gtk.StyleContext()
context.add_provider_for_screen(screen, provider, Gtk.STYLE_PROVIDER_PRIORITY_USER)


Gtk.main()
