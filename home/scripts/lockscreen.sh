#!/usr/bin/env bash

if pgrep -x swaylock ; then
    echo "locked"
    exit 0
fi

swaylock \
    -f \
    --image ~/.wallpaper/wallpaper \
    --font "Hack Nerd Font Mono" \
    --clock \
    --indicator \
    --indicator-radius 150 \
    --indicator-thickness 7 \
    --ring-color bb00cc \
    --key-hl-color 880033 \
    --line-color 00000000 \
    --inside-color 00000088 \
    --separator-color 00000000 \
    --fade-in 0.0 \
    # --grace 2 \
    # --effect-blur 17x1 \
