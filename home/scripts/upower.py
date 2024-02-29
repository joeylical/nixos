#!/usr/bin/env python
# https://people.freedesktop.org/~lkundrak/nm-docs/
import os
import sys
import json
import time
import threading
from dasbus.connection import SystemMessageBus
from dasbus.identifier import DBusInterfaceIdentifier
from dasbus.loop import EventLoop


bus = SystemMessageBus()

proxy = bus.get_proxy(
            "org.freedesktop.UPower", 
            "/org/freedesktop/NetworkManager",
            "org.freedesktop.NetworkManager", 
)

def get_bat_icon(per):
    icons = '󰁺󰁻󰁼󰁽󰁾󰁾󰁿󰂀󰂁󰂂󰁹'
    per //=10
    per = int(per)
    return icons[per]

def get_dev_icon(model:str):
    model = model.lower()
    if 'mouse' in model:
        return '󰍽'
    return '󰾰'

def refresh(mid=None, reason=None):
    # battery
    bat_status = []
    bat = bus.get_proxy(
                "org.freedesktop.UPower", 
                "/org/freedesktop/UPower/devices/battery_BAT0",
                "org.freedesktop.UPower.Device", 
    )
    adp = bus.get_proxy(
                "org.freedesktop.UPower", 
                "/org/freedesktop/UPower/devices/line_power_ADP0",
                "org.freedesktop.UPower.Device", 
    )
    p = bat.Percentage
    if adp.Online:
        bat_status.append('󱐥')
    else:
        bat_status.append(get_bat_icon(p))
    bat_status.append(str(int(p))+'%')
    
    e = bus.get_proxy("org.freedesktop.UPower", "/org/freedesktop/UPower", "org.freedesktop.UPower")
    
    for path in e.EnumerateDevices():
        _, devname = os.path.split(path)
        if devname not in ['DisplayDevice', 'battery_BAT0', 'line_power_ADP0']:
            dev = bus.get_proxy("org.freedesktop.UPower", path, "org.freedesktop.UPower.Device")
            if dev.Online:
                bat_status.append(get_dev_icon(dev.Model))
                bat_status.append(str(int(dev.Percentage))+'%')

    print(' '.join(bat_status))
    sys.stdout.flush()

while True:
    refresh()
    time.sleep(30)
