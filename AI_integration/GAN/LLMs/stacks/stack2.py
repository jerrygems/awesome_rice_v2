import gi
gi.require_version("Gtk", "3.0")
from gi.repository import Gtk

class SecondStack(Gtk.Box):
    def __init__(self):
        super().__init__()
        main_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)
        main_box.set_name("mainBox")
        main_box.set_hexpand(True)
        
    
        
        # head
        row1 = Gtk.Box()
        row1.set_name("r1")
        row1.set_size_request(-1,60)
        
        btn1 = Gtk.Button("󱎘")
        btn1.set_name("button")
        row1.pack_start(btn1,False,False,0)
        
        
        row2 = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)
        row2.set_name("r2")
        row2.set_size_request(-1,80)
        
        head = Gtk.Label("API KEYS")
        head.set_name("models")
        para= Gtk.Label("Please enter your API key here to be used")
        para.set_name("para")
        row2.pack_start(head,True,True,0)
        row2.pack_start(para,True,True,0)
        
        
        
        
        row3 = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL)
        row3.set_name("r3")
        row3.set_halign(Gtk.Align.CENTER)
        
        inp_box = Gtk.Entry()
        inp_box.set_placeholder_text("Enter the API key here...")
        inp_box.set_name("inp_box")
        inp_box.set_size_request(400,-1)
        submit_btn = Gtk.Button("SUBMIT")
        submit_btn.set_name("submit_btn")
        submit_btn.set_size_request(100,-1)
        row3.pack_start(inp_box,False,False,0)
        row3.pack_start(submit_btn,False,False,0)
        
            
            
        
        main_box.pack_start(row1,False,True,0)
        main_box.pack_start(row2,True,True,0)
        main_box.pack_start(row3,True,False,0)
        self.add(main_box)
