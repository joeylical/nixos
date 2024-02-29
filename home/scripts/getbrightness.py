#!/usr/bin/env python
import sys
import time


bl = '/sys/class/backlight/nvidia_wmi_ec_backlight/brightness'
blmax = '/sys/class/backlight/nvidia_wmi_ec_backlight/max_brightness'

with open(blmax, 'r') as f:
    lmax = f.read()
    lmax = int(lmax)

last = 0
while True:
    with open(bl, 'r') as f:
        l = f.read()
        l = int(l) * 100
    p = int(l / lmax + 0.5)
    if p != last:
        last = p
        print(p)
        sys.stdout.flush()
    time.sleep(0.5)
