#!/usr/bin/env python
# https://people.freedesktop.org/~lkundrak/nm-docs/
import sys
import json
import threading
from dasbus.connection import SystemMessageBus
from dasbus.identifier import DBusInterfaceIdentifier
from dasbus.loop import EventLoop


class NM_DEVICE_TYPE:
    ETHERNET = 1
    WIFI = 2
    BT = 3

class NM_DEVICE_STATE:
    UNAVAILABLE = 20
    DISCONNECTED = 30
    NEED_AUTH = 60
    ACTIVATED = 100
    DEACTIVATING = 110
    FAILED = 120

bus = SystemMessageBus()

proxy = bus.get_proxy(
            "org.freedesktop.NetworkManager", 
            "/org/freedesktop/NetworkManager",
            "org.freedesktop.NetworkManager", 
)

network_info_default = {
    'icon': '󰤭',
    'tooltip': '',
    'wifi': {
        'icon': '󰤭',
        'ssid': '',
        'switch': False,
    },
    'eth': {
        'icon': '󰈀',
    },
}

network_info = dict(network_info_default)
prim_conn = None
prim_dev = None

def get_wifi(dev):
    icons = '󰤟󰤢󰤥󰤨'
    if dev.State == NM_DEVICE_STATE.UNAVAILABLE:
        return False, '󰤭', '', f'{dev.Interface} Off'
    elif dev.State == NM_DEVICE_STATE.DISCONNECTED:
        return True, '󰤯', '', f'{dev.Interface} Disconnected'
    elif dev.State != NM_DEVICE_STATE.ACTIVATED:
        return True, '󰤫', '', f'{dev.Interface} code:{dev.State}'

    path = dev.ActiveAccessPoint
    ap = bus.get_proxy('org.freedesktop.NetworkManager', path)
    ssid = bytes(ap.Ssid).decode('utf-8')
    strength = ap.Strength
    if strength == 100:
        strength = 99
    strength //= 25;
    tooltip = f'{dev.Interface} {ssid} {ap.Frequency/1000}GHz {dev.Bitrate//1000}Mbps'
    return True, icons[strength], ssid, tooltip

def get_eth(dev):
    tooltip = f'{dev.Interface} {"un" if not dev.Carrier else ""}plugged {dev.Speed}Mbps'
    return tooltip

def refresh(mid=None, reason=None):
    global prim_dev, prim_conn
    network_info = dict(network_info_default)
    prim_conn = proxy.PrimaryConnection
    for dev in proxy.GetDevices():
        p = bus.get_proxy("org.freedesktop.NetworkManager", dev)
        if p.ActiveConnection == prim_conn:
            prim_dev = p
        match p.DeviceType:
            case NM_DEVICE_TYPE.WIFI:
                switch, icon, ssid, tooltip = get_wifi(p)
                network_info['wifi']['switch'] = switch
                network_info['wifi']['icon'] = icon
                network_info['wifi']['ssid'] = ssid
                if prim_dev == p:
                    network_info['icon'] = network_info['wifi']['icon']
                    network_info['tooltip'] = tooltip
            case NM_DEVICE_TYPE.ETHERNET:
                if prim_dev == p:
                    network_info['icon'] = network_info['eth']['icon']
                    network_info['tooltip'] = get_eth(p)
            case _:
                pass

    print(json.dumps(network_info, separators=(',', ':'), sort_keys=True))
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
proxy.StateChanged.connect(refresh)
loop.run()

