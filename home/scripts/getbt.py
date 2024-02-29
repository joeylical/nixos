#!/usr/bin/env python
# https://ukbaz.github.io/howto/python_gio_1.html
import sys
import re
import json
import threading
from dasbus.connection import SystemMessageBus
from dasbus.identifier import DBusInterfaceIdentifier
from dasbus.loop import EventLoop


bus = SystemMessageBus()

proxy = bus.get_proxy(
            "org.bluez", 
            "/org/bluez/hci0",
            "org.bluez.Adapter1", 
)

icons = {
    'audio-headset': '󰋎'
}

bt_info_default = {
    'icon': '󰂲',
    'icons': '󰂲',
    'switch': False,
    'label': '',
    'tooltip': '',
}

dev_partten = re.compile('^/org/bluez/hci0/dev(_[0-9a-fA-F]{2}){6}$')


def refresh(mid=None, reason=None):
    bt_info = dict(bt_info_default)
    icon = []
    label = ''
    tooltip = ''
    if not proxy.Powered:
        bt_info['switch'] = False
        bt_info['icon'] = '󰂲'
        icon.append('󰂲')
    else:
        bt_info['switch'] = True
        bt_info['icon'] = '󰂯'
        icon.append('󰂯')
        tooltip = f'Name: {proxy.Name}\nAddr: {proxy.Address}\n'
        p = bus.get_proxy("org.bluez", "/", "org.freedesktop.DBus.ObjectManager")
        
        for k, v in p.GetManagedObjects().items():
            if dev_partten.match(k):
                dev = bus.get_proxy("org.bluez", k, "org.bluez.Device1")
                if dev.Connected:
                    icon[0] = '󰂱'
                    bt_info['icon'] = '󰂱'
                    if dev.Icon in icons:
                        icon.append(icons[dev.Icon])
                    else:
                        icon.append('󰾰')
                    tooltip = tooltip + f'{dev.Alias} {dev.Address} {dev.Icon}\n'
                    label = dev.Alias
    bt_info['icons'] = ' '.join(icon)
    bt_info['label'] = label
    bt_info['tooltip'] = tooltip.strip()
    print(json.dumps(bt_info, separators=(',', ':'), sort_keys=True))
    sys.stdout.flush()

refresh()

def timer_loop():
    import time
    while True:
        time.sleep(30)
        refresh()

timer = threading.Thread(target=timer_loop)
timer.daemon = True
timer.start()

loop = EventLoop()
# p = bus.get_proxy("org.bluez", "/org/bluez/hci0", "org.freedesktop.DBus.Properties")
p = bus.get_proxy("org.bluez", "/", "org.freedesktop.DBus.ObjectManager")
p.InterfacesAdded.connect(refresh)
p.InterfacesRemoved.connect(refresh)
loop.run()

