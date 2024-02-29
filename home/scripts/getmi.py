#!/usr/bin/env python
import os
import re
import sys
import json
import hashlib
import random
import threading
import requests
from dasbus.connection import SessionMessageBus
from dasbus.identifier import DBusInterfaceIdentifier
from dasbus.loop import EventLoop


bus = SessionMessageBus()

proxy = bus.get_proxy(
            "org.mpris.MediaPlayer2.playerctld", 
            "/org/mpris/MediaPlayer2",
            "com.github.altdesktop.playerctld", 
)

mc_template = """
(box
  :valign "start"
  :orientation "v"
  :space-evenly "false"
  :style "margin 0px;"

  {}

)
"""

mc_scroll_template = """
(scroll
  :vscroll "true"
  (box
    :orientation "v"
    :space-evenly "false"

    {}

  )
)
"""

player_template = """
(box
  :valign "start"
  :space-evenly "false"
  :class "music-player-container"
  (box
    :class "music-player-album"
    :style "background-image: url('{image}')")
  (box
    :width 230
    :orientation "v"
    :space-evenly "false"
    :style "margin: 0px 5px;"
    (label
      :class "music-title"
      :halign "start" 
      :text "{title}")
    (label
      :class "music-aa"
      :halign "start" 
      :text "{line2}")

    (box :height 12)

    (box
      :space-evenly "true"
      :valign "end"
      :style "margin: 0px; padding: 0px;"
      (button
        :onclick "playerctl -p '{controller}' previous" "󰒮")
      (button
        :onclick "playerctl -p '{controller}' play-pause" "{icon}")
      (button
        :onclick "playerctl -p '{controller}' next" "󰒭"))))
"""

player_seekable_template = """
(box
  :valign "start"
  :space-evenly "false"
  :class "music-player-container"
  (box
    :class "music-player-album"
    :style "background-image: url('{image}')")
  (box
    :width 230
    :orientation "v"
    :space-evenly "false"
    :style "margin: 0px 5px;"
    (label
      :class "music-title"
      :halign "start" 
      :text "{title}")
    (label
      :class "music-aa"
      :halign "start" 
      :text "{line2}")

    (box :height 12)

    (box
      :width 220
      :halign "end" 
      :orientation "v"
      :space-evenly "false"
      (scale 
        :class "pos-slider"
        :value {pos100}
        :orientation "h"
        :round-digits 0
        :width 150
        :marks false
        :max 100
        :min 0
        :onchange "playerctl -p '{controller}' position $(expr $(({length}*{{}})) / 100)"))

    (box
      :space-evenly "true"
      :valign "end"
      (box
        :width 10
        :halign "start"
        :space-evenly "false"
        (label
          :width 10
          :halign "start"
          :style "font-size: 9px;margin: 0px;padding: 0px;"
          :text "{cur}")
        (button
          :halign "start"
          :style "margin-left: 10px;"
          :onclick "playerctl -p '{controller}' previous" "󰒮"))
      (button
        :onclick "playerctl -p '{controller}' play-pause" "{icon}")
      (box
        :width 10
        :halign "end"
        :space-evenly "false"
        (button
          :halign "end"
          :style "margin-right: 10px;"
          :onclick "playerctl -p '{controller}' next" "󰒭")
        (label
          :width 10
          :halign "end"
          :style "font-size: 9px;margin: 0px;padding: 0px;"
          :text "{total}")))))
"""

def get_rnd_fname(url):
    md5 = hashlib.md5(url.encode('utf-8')).digest()
    md5 = map('{:02x}'.format, md5)
    md5 = ''.join(md5)
    return '/tmp/player_metadata_' + md5

def wrap_file(url:str):
    if url.startswith('file://'):
        return url[7:]
    elif url.startswith('http'):
        fname = get_rnd_fname(url)
        if not os.path.exists(fname):
            c = requests.get(url)
            with open(fname, 'wb') as f:
                f.write(c.content)
        return fname

def line_limits(s, limit=26):
    out = []
    for c in s:
        if ord(c) < 128:
            limit -= 1
            out.append(c)
        else:
            limit -= 2
            out.append(c)
        if limit <= 0:
            out.append('...')
            break

    return ''.join(out)

def get_second_line(info):
    MAX_LEN = 34
    album = info['album']
    artist = info['artist']
    if len(album) == 0 and len(artist) == 0:
        return ''
    elif len(album) == 0:
        return line_limits(artist)
    elif len(artist) == 0:
        return line_limits(album)
    else:
        album_len = 0
        for c in album:
            if ord(c) < 128:
                album_len += 1
            else:
                album_len += 2
        artist_len = 0
        for c in artist:
            if ord(c) < 128:
                artist_len += 1
            else:
                artist_len += 2
        if album_len + artist_len + 3 <= MAX_LEN:
            return album + ' - ' + artist
        elif album_len < MAX_LEN - 12:
            return album + ' - ' + line_limits(artist, MAX_LEN - 3 - album_len)
        else:
            return line_limits(album, MAX_LEN - 3 - artist_len) + ' - ' + artist

def get_icon(info):
    icon_play = ''
    icon_pause = ''
    if info['status']:
        info['icon'] = icon_pause
    else:
        info['icon'] = icon_play

def pos_to_time(pos):
    pos = int(pos)
    pos //= 1000000
    return pos

def time_s(t):
    m = t//60
    s = t%60
    return f'{m}:{s:02}'

def refresh():
    players = proxy.PlayerNames

    outs = []
    for player in players:
        p = bus.get_proxy(
                    player,
                    "/org/mpris/MediaPlayer2",
                    "org.mpris.MediaPlayer2.Player"
                )
        info = {
            'player': player.split('.')[3],
            'controller': player[23:],
            'image': wrap_file(str(p.Metadata['mpris:artUrl'].get_string())) if 'mpris:artUrl' in
            p.Metadata else '',
            'title': line_limits(str(p.Metadata['xesam:title'].get_string())),
            'artist': ', '.join(map(str, p.Metadata['xesam:artist'])),
            'album': str(p.Metadata['xesam:album'].get_string()),
            'status': p.PlaybackStatus == 'Playing',
            'canseek': str(hasattr(p, 'CanSeek') and p.CanSeek).lower(),
            'cannext': str(hasattr(p, 'CanGoNext') and p.CanGoNext).lower(),
            'canprev': str(hasattr(p, 'CanGoPrevious') and p.CanGoPrevious).lower(),
            'shuffle': hasattr(p, 'Shuffle') and p.Shuffle,
            'seekable': 'mpris:length' in p.Metadata,
        }
        info['line2'] = get_second_line(info)
        get_icon(info)
        if info['seekable']:
            # print(p.Metadata['mpris:length'].get_int64())
            info['length'] = pos_to_time(int(p.Metadata['mpris:length'].get_int64()))
            info['pos'] = pos_to_time(p.Position)
            info['pos100'] = int(100*pos_to_time(p.Position)/info['length'])
            info['cur'] = time_s(info['pos'])
            info['total'] = time_s(info['length'])
            out = player_seekable_template.format(**info)
        else:
            out = player_template.format(**info)
        outs.append(out)
    c = '\n'.join(outs)
    # c = '(box ' + c + ')'
    # c = c.replace('\n', ' ')
    print(mc_template.format(c))

refresh()
exit()

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

