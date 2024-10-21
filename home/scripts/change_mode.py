#!/usr/bin/env python
import os
import sys
import re

if len(sys.argv) != 2:
    exit()

mode = sys.argv[1].lower()

if mode not in ('dark', 'light', 'toggle'):
    exit()

MODE_DARK = 'Dark'
MODE_LIGHT = 'Light'

HOME_DIR = os.environ['HOME']
CONFIG_DIR = os.environ['XDG_CONFIG_HOME']

GTK_RE = r'^gtk-theme-name="*Flat-Remix-GTK-(?P<color>\w+)-(?P<mode>[\w-]+)"*$'
GTK2_FORMAT = 'gtk-theme-name="Flat-Remix-GTK-{color}-{mode}"'
GTK3_FORMAT = 'gtk-theme-name=Flat-Remix-GTK-{color}-{mode}'

if mode == 'toggle':
    with open(os.path.join(HOME_DIR, '.darkmode')) as f:
        m = f.read().strip()
        if m == 'light':
            mode = 'dark'
        else:
            mode = 'light'

if mode == 'dark':
    MODE = MODE_DARK
else:
    MODE = MODE_LIGHT


def apply(mode):
    paths = [
            os.path.join(HOME_DIR, '.gtkrc-2.0'), 
            os.path.join(CONFIG_DIR, 'gtk-3.0/settings.ini'), 
            os.path.join(CONFIG_DIR, 'gtk-4.0/settings.ini')]

    for path, fmt in zip(paths, [GTK2_FORMAT, GTK3_FORMAT, GTK3_FORMAT]):
        with open(path, 'r') as f:
            content = f.read()
            m = re.search(GTK_RE, content, re.MULTILINE)
            if m is not None:
                content = re.sub(m.group(0), fmt.format(color=m.group('color'), mode=MODE), content)
                # print(content)
                with open(path, 'w') as f:
                    f.write(content)
            else:
                print('not found in: ', path)

apply(MODE)
os.system('configure-gtk')
