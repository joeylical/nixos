#!/usr/bin/env sh

set -e

key=`cat ~/.openweathermap`

# loc="Beijing"
# defined in ./nixos/default.nix which refered to ./config.nix
loc=$CITY

url="https://api.openweathermap.org/data/2.5/weather?q=$loc&appid=$key"

json=$(curl $url 2>/dev/null)

declare -A icons

# https://openweathermap.org/weather-conditions
icons=(
    # clear sky
    ["01d"]="󰖙"
    ["01n"]="󰖔"

    # few clouds
    ["02d"]="󰖕"
    ["02n"]="󰼱"

    # scattered clouds
    ["03d"]="󰖐"
    ["03n"]="󰖐"

    # broken clouds
    ["04d"]=""
    ["04n"]=""

    # shower rain
    ["09d"]="󰖖"
    ["09n"]="󰖖"

    # rain
    ["10d"]="󰼳"
    ["10n"]="󰖗"

    # thunderstorm
    ["11d"]="󰙾"
    ["11n"]="󰙾"

    # snow
    ["13d"]="󰖘"
    ["13n"]="󰖘"

    # mist
    ["50d"]="󰖑"
    ["50n"]="󰖑"
)

directions=("" "" "" "" "" "" "" "")

weather_icon=$(echo $json|jq -r '.weather[].icon')
temp=$(echo $json|jq -r '.main.temp')
temp=$(echo "$temp-273.15"|bc)
humidity=$(echo $json|jq -r '.main.humidity')
direction=$(echo $json|jq -r '.wind.deg')
direction=$(($direction+23+360))
direction=$(($direction%360))
direction=$(($direction/45))
speed=$(echo $json|jq -r '.wind.speed')


printf "{"
printf "\"text\": \"${icons[$weather_icon]} %.1f°C\"," $temp
printf "\"tooltip\": \"${icons[$weather_icon]}  %.1f°C  %.1f󱉸  ${directions[$direction]} %.1fm/s\"" $temp $humidity $speed
printf "}"

