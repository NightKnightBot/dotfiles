#!/usr/bin/env bash
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots  >/dev/null 2>&1 & 
swww-daemon  >/dev/null 2>&1 & 
nm-applet  >/dev/null 2>&1 & 
copyq  >/dev/null 2>&1 & 
dunst  >/dev/null 2>&1 & 
waybar -c /home/anand/dots/mango/waybar/config.jsonc -s /home/anand/dots/mango/waybar/style.css  >/dev/null 2>&1 & 
swww img /home/anand/dots/mango/walls/wallpaper.jpg  >/dev/null 2>&1 & 
xrdb .Xresources  >/dev/null 2>&1 & 
# The next line of command is not necessary. It is only to avoid some situations where it cannot start automatically
