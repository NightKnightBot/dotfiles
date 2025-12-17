#!/bin/bash
slurp | grim -g - - | wl-copy
choice=$(printf "save to clipboard\nsave to file" | rofi -dmenu)

case "$choice" in
  "Save to File")
    wl-paste > ~/Pictures/Screenshots/screenshot-$(date +%F_%H-%M-%S).png
    ;;
  *)
    exit 0
    ;;
esac
