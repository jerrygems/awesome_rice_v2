import gi
gi.require_version("Gtk", "3.0")
from gi.repository import Gtk

class ThirdStack(Gtk.Box):
    def __init__(self):
        super().__init__()
        main_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)
        main_box.set_name("mainBox")
        main_box.set_hexpand(True)

        
        row1 = Gtk.Box()
        row1.set_name("r1")
        row1.set_size_request(-1,60)
        
        btn1 = Gtk.Button("󱎘")
        btn1.set_name("button")
        row1.pack_start(btn1,False,False,0)
        
        
        row2 = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)
        row2.set_name("r2")
        row2.set_size_request(-1,60)
        
        head = Gtk.Label("ELLIOT")
        head.set_name("models1")
        para= Gtk.Label("Please enter your API key here to be used")
        para.set_name("para1")
        row2.pack_start(head,True,True,0)
        row2.pack_start(para,True,True,0)

        row3 = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)
        row3.set_name("s3r3")
        
        scroll_window = Gtk.ScrolledWindow()
        scroll_window.set_name("scrolledWindow")
        
        

        input_wrapper = Gtk.Box(Gtk.Align.CENTER)
        input_wrapper.set_name("input_wrapper")
        input_wrapper.set_homogeneous(False)
        input_wrapper.set_halign(Gtk.Align.CENTER)

        input_box = Gtk.Entry()
        input_box.set_name("inp_box1")
        input_box.set_placeholder_text("Prompt here...")
        submit_btn = Gtk.Button("󰑚")
        submit_btn.set_name("submit_btn1")
        
        input_wrapper.pack_start(input_box,False,False,0)
        input_wrapper.pack_start(submit_btn,False,False,0)
        

        row3.pack_start(scroll_window,True,True,0)
        row3.pack_start(input_wrapper,False,False,0)

        main_box.pack_start(row1,False,True,0)
        main_box.pack_start(row2,False,False,0)
        main_box.pack_start(row3,True,True,0)
        self.add(main_box)
