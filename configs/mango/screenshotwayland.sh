#!/usr/bin/env bash
input_type=$(printf "region\nwindow" | rofi -dmenu)
case "$input_type" in
  "window")
    # hyprshot -m window --clipboard-only
    grim -g "$(slurp)" - | wl-copy
    ;;
  *)
    # hyprshot -m region --clipboard-only
    grim -g "$(slurp)" - | wl-copy
    ;;
esac

choice=$(printf "save to clipboard\nsave to file" | rofi -dmenu)

case "$choice" in
  "save to file")
    wl-paste > ~/Pictures/Screenshots/screenshot-$(date +%F_%H-%M-%S).png
    ;;
  *)
    exit 0
    ;;
esac
