import gi 
import subprocess 

networks = subprocess.check_output(['nmcli','-t','-f','SSID','dev','wifi','list'])
ssids = networks.decode().splitlines()
ssids = [ssid for ssid in ssids if ssid]

print(ssids)

def run_subprocess(ssid):
    print(ssid)
    #subprocess.run(["nmcli","device", "wifi", "connect", ssid])

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk 

network_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)

win=Gtk.Window()
win.connect("destroy", Gtk.main_quit)
win.set_default_size(400, 300)

for ssid in ssids:
    network_button = Gtk.Button(label=ssid)
    
    network_button.connect("bleh", lambda button, label=id: connect(label))
    network_box.pack_start(network_button, False, False, 0)

win.add(network_box)
win.show_all()
Gtk.main()


