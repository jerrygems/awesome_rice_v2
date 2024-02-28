import gi
gi.require_version("Gtk", "3.0")
from gi.repository import Gtk

class FirstStack(Gtk.Box):
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
        
        
        row2 = Gtk.Box()
        row2.set_name("r2")
        row2.set_size_request(-1,80)
        
        head = Gtk.Label("MODELS")
        head.set_name("models")
        row2.pack_start(head,True,True,0)
        
        
        
        row3 = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)
        row3.set_name("r3")
        
        models = ["PALM","BERT","GPT 3.5","GPT 3.0","LLAMA","CLAUDE"]
        words = ["PALM","BERT","GPT_3.5","GPT_3.0","LLAMA","CLAUDE"]
        btns = [Gtk.Button(models[i]) for i in range(len(models)) ]
            
        for btn,word in zip(btns,words):
            btn.set_name(word)
            btn.get_style_context().add_class("btnsInList")
            row3.pack_start(btn,False,False,0)
            
            
        
        main_box.pack_start(row1,False,True,0)
        main_box.pack_start(row2,True,True,0)
        main_box.pack_start(row3,True,False,0)
        self.add(main_box)
