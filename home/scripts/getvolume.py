#!/usr/bin/env python
import os
import re
import sys
import json
import time
import subprocess


number_pattern = re.compile('\d+%')
def get(dev):
    cmd = f'amixer sget {dev}'
    p = os.popen(cmd, 'r')
    line = p.readlines()[-1]
    p.close()
    num = number_pattern.search(line)
    num = num.group()[:-1]
    return int('[on]' in line), int(num)

def get_json():
    o_icon, o_volume = get('Master')
    time.sleep(0.1)
    i_icon, i_volume = get('Capture')
    out_icons = '󰖁󰕾'
    in_icons = '󰍭󰍬'
    o = {
        'out': {
            'icon': out_icons[o_icon],
            'volume': o_volume
        },
        'in': {
            'icon': in_icons[i_icon],
            'volume': i_volume
        }
    }

    return json.dumps(o, separators=(',',':'), sort_keys=True)

print(get_json())
sys.stdout.flush()

# os.putenv('TERM', 'xterm')

time.sleep(0.1)
cmd = "pw-cli -m 2>&1"
p = subprocess.Popen(cmd, shell=True, stdin=subprocess.PIPE, stdout=subprocess.PIPE,
                     stderr=subprocess.PIPE)

changed = re.compile('device \d+ changed')
while p.poll() is None:
    line = p.stdout.readline().decode('utf-8')
    if changed.search(line) is not None:
        print(get_json())
        sys.stdout.flush()
    # time.sleep(0.1)

