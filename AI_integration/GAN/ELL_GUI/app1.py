import gi
gi.require_version("Gtk", "3.0")
from gi.repository import Gtk, Gdk
import os

script_path = os.path.abspath(__file__)
script_dir = os.path.dirname(script_path)
css_path = os.path.join(script_dir, "../style.css")

class MainWindow(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="ELLIOT")
        self.set_default_size(600, 400)

        # here is the notebook
        self.notebook = Gtk.Notebook()
        self.add(self.notebook)
        
        # now time to create stack
        self.stack = Gtk.Stack()
        self.stack.set_transition_type(Gtk.StackTransitionType.SLIDE_LEFT_RIGHT)
        self.notebook.append_page(self.stack,None)
        
        # creating pages here
        self.create_page1()
        
    def create_page1(self):
        self.main_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)# create box
        self.main_box.set_name("themainbox") # set name
        self.add(self.main_box) # add the box to the Gtk.Window using the add func

        self.row1 = Gtk.Box()
        self.row1.set_name("row1")
        self.row1.set_vexpand(True)
        # self.row1.set_size_request(-1, 100)
        
        self.back_button = Gtk.Button.new_with_label("󰌍") # created the button
        self.back_button.set_name("backButton")
        self.row1.pack_start(self.back_button,False,False,0) # added it to the row1

        self.c1 = Gtk.Box()
        self.c1.set_name("c1")
        self.c2 = Gtk.Box()
        self.c2.set_name("c2")
        self.label = Gtk.Label(label="ELLIOT")
        self.label.set_name("elliot")
        self.c2.pack_start(self.label,False,False,0)
        
        self.row2 = Gtk.Box()
        self.row2.set_name("row2")
        self.row2.set_vexpand(True)
        self.row2.pack_start(self.c1,True,False,0)
        self.c1.pack_end(self.c2,True,False,0)
        
        self.row3 = Gtk.Box() 
        self.row3.set_name("row3")
        self.row3.set_vexpand(True)
        # circular button 1
        self.btn1 = Gtk.Button(label="")
        self.btn1.set_name("btn1")
        
        
        # circular button 2
        self.btn2 = Gtk.Button(label="",halign=Gtk.Align.CENTER)
        self.btn2.set_name("btn2")
        
        # adding both here
        self.row3.pack_start(self.btn1,False,False,0)
        self.row3.pack_start(self.btn2,True,False,0)
        
        
        self.main_box.pack_start(self.row1,True,False,0)        
        self.main_box.pack_start(self.row2, True, False, 0)
        self.main_box.pack_start(self.row3, False, False, 0)
        
        
        self.stack.add_titled(self.main_box, "", "") 
        
   
    

# after seeing this thing you gonna laugh

win = MainWindow()
win.connect("destroy", Gtk.main_quit)
win.show_all()

provider = Gtk.CssProvider()
provider.load_from_path(css_path)
screen = Gdk.Screen.get_default()
context = Gtk.StyleContext()
context.add_provider_for_screen(screen, provider, Gtk.STYLE_PROVIDER_PRIORITY_USER)

Gtk.main()