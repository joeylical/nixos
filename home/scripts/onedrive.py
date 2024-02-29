#!/usr/bin/env python
import os
import sys
import glob

config_path = os.path.join(os.environ['HOME'], '.config/onedrive/accounts', '*')
config_path = glob.glob(config_path)[0]
p = os.popen(f'onedrive --confdir={config_path} --monitor -v', 'r')

icon = '󰔪'
size = ''
while True:
    line = p.readline().strip()
    if 'Remaining Free Space: ' in line:
        size = line.split(' ')[-1]
        size = int(size)
        size //= 1024 * 1024
        size = f'Free:{size}GB'
    if 'Processing' in line:
        icon = '󰘿'
    elif 'complete' in line:
        icon = '󰅠'
    elif 'Monitored directory removed' in line:
        icon = '󰅠'
    elif 'Creating local directory: ' in line:
        icon = '󰅠'
    elif 'Successfully created the remote directory' in line:
        icon = '󰅠'
    elif 'Moving' in line:
        icon = '󰅠'
    elif 'Deleting' in line:
        icon = '󰅠'
    elif 'Uploading' in line:
        icon = '󰅧'
    elif 'Downloading' in line:
        icon = '󰅢'
    print(icon)
    sys.stdout.flush()
