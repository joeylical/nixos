#!/usr/bin/env python
import os
import sys
import time
import requests

# loc = os.environ['CITY']
loc = 'calgary'
key_path = os.path.join(os.environ['HOME'], '.openweather')
with open(key_path, 'r') as f:
    key = f.readline().strip()
url = f"https://api.openweathermap.org/data/2.5/weather?q={loc}&appid={key}"

image_cache = os.path.join('/',os.environ['HOME'], './.cache/weather/')

if not os.path.exists(image_cache):
    os.mkdir(image_cache)

def fetch_image(icon):
    url = f'https://openweathermap.org/img/wn/{icon}@2x.png'
    file = f'{image_cache}{icon}'
    file = os.path.normpath(file)
    if not os.path.exists(file):
        r = requests.get(url)
        with open(file, 'wb') as f:
            f.write(r.content)
    return file

def fetch_icon(icon):
    icons = {
        "01d" : "󰖙",
        "01n" : "󰖔",
        "02d" : "󰖕",
        "02n" : "󰼱",
        "03d" : "󰖐",
        "03n" : "󰖐",
        "04d" : "",
        "04n" : "",
        "09d" : "󰖖",
        "09n" : "󰖖",
        "10d" : "󰼳",
        "10n" : "󰖗",
        "11d" : "󰙾",
        "11n" : "󰙾",
        "13d" : "󰖘",
        "13n" : "󰖘",
        "50d" : "󰖑",
        "50n" : "󰖑",
    }
    return icons[icon]


def wind(w):
    # directions = ["","","","","","","",""]
    directions = ["N","NE","E","SE","S","SW","W","NW"]
    di = w['wind']['deg']
    di += 22.5 + 360
    di %= 360
    di /=45
    di = int(di)
    di = directions[di]
    return di, w['wind']['speed']


while True:
    try:
        weather = {}
        data = requests.get(url)
        sleep_time = 10
        if data.status_code == 200:
            sleep_time = 60 * 10
            w = data.json()
            weather['main'] = w['weather'][0]['main']
            weather['description'] = w['weather'][0]['description']
            weather['image'] = fetch_image(w['weather'][0]['icon'])
            weather['icon'] = fetch_icon(w['weather'][0]['icon'])
            weather['temp'] = '{:.1f}'.format(w['main']['temp'] - 273.15)
            weather['humidity'] = '{}'.format(w['main']['humidity'])
            wind_di, wind_speed = wind(w)
            weather['wind_di'] = wind_di
            weather['wind_speed'] = '{:.1f}'.format(wind_speed)

        # print(json.dumps(weather, separators=(',', ':'), sort_keys=True))
        print(f'{{"text":"{weather["icon"]} {weather["temp"]}°C","class":""}}')
        sys.stdout.flush()
    except:
        sleep_time = 3

    time.sleep(sleep_time)

