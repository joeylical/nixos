#!/usr/bin/env bash

brightnessctl -c backlight set $1

current_light=$(brightnessctl -c backlight g)

if [ $current_light -lt 4 ]; then
    brightnessctl -c backlight set 4
fi
