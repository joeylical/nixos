#!/usr/bin/env python
import sys
import time
from dasbus.connection import SessionMessageBus
from dasbus.identifier import DBusInterfaceIdentifier
from dasbus.loop import EventLoop


bus = SessionMessageBus()

proxy = bus.get_proxy( 'org.fcitx.Fcitx5', '/controller','org.fcitx.Fcitx.Controller1')

outs = {
    'keyboard-us': 'us',
    'keyboard-fr': 'fr',
    'rime': 'zh'
}

last = ''
idle_times = 10
while True:
    try:
        cur = proxy.CurrentInputMethod()
        if last != cur:
            print(outs[cur])
            sys.stdout.flush()
            last = cur
        else:
            if idle_times > 0:
                idle_times -= 1
            else:
                print(outs[cur])
                idle_times = 10
    except:
        last = ''
        idle_times = 10

    time.sleep(1)
