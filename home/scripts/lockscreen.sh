#!/usr/bin/env bash

if pgrep -x swaylock ; then
    echo "locked"
    exit 0
fi

swaylock \
    --font "Hack Nerd Font Mono" \
    --screenshots \
    --clock \
    --indicator \
    --indicator-radius 150 \
    --indicator-thickness 7 \
    --effect-blur 17x5 \
    --ring-color bb00cc \
    --key-hl-color 880033 \
    --line-color 00000000 \
    --inside-color 00000088 \
    --separator-color 00000000 \
    --grace 2 \
    --fade-in 0.2 \
    # --image ~/.wallpaper/wallpaper \
