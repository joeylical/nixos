#!/usr/bin/env bash

fps="$1"
case ${fps} in
    "30") hyprctl keyword monitor eDP-1,3072x1920@30,0x0,2
    ;;
    "60") hyprctl keyword monitor eDP-1,3072x1920@60,0x0,2
    ;;
    "120") hyprctl keyword monitor eDP-1,3072x1920@120,0x0,2
    ;;
    *) echo Bad Parameter!
esac
pkill -RTMIN+20 waybar