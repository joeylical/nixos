#!/usr/bin/env bash

wp="$1"
case ${wp} in
"dark") file=$(ls /etc/nixos/home/wallpapers/dark|sort -R|head -n 1)
    file="/etc/nixos/home/wallpapers/dark/$file"
    ;;
"light") file=$(ls /etc/nixos/home/wallpapers/light|sort -R|head -n 1)
    file="/etc/nixos/home/wallpapers/light/$file"
    ;;
*)
    config="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-3.0/settings.ini"
    if [ ! -f "$config" ]; then exit 1; fi
    gtk_theme="$(grep 'gtk-theme-name' "$config" | sed 's/.*\s*=\s*//')"
    echo $gtk_theme | grep -qi 'Dark' && DARKMODE="dark" || DARKMODE="light"
    file=$(ls /etc/nixos/home/wallpapers/$DARKMODE|sort -R|head -n 1)
    file="/etc/nixos/home/wallpapers/$DARKMODE/$file"
    ;;
esac
cp -f $file ~/.wallpaper/wallpaper
hyprctl hyprpaper preload "$file"
hyprctl hyprpaper wallpaper "eDP-1,$file"
