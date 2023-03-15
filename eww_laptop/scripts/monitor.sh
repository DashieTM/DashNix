#!/bin/bash

onlysecond() {
  dunstify "Switching to external monitor only"
  hyprctl keyword monitor ,highrr,0x0,1
  hyprctl keyword monitor eDP-1,disabled
}

onlyfirst() {
  dunstify "Switching to internal monitor only"
  hyprctl keyword monitor ,disabled
  hyprctl keyword monitor eDP-1,1920x1080@144,0x0,1
}

extend() {
  dunstify "Switching to extend mode"
  hyprctl keyword monitor ,highrr,1920x0,1
  hyprctl keyword monitor eDP-1,1920x1080@144,0x0,1
}

mirror() {
  dunstify "Switching to mirror mode"
  hyprctl keyword monitor ,highrr,0x0,1
  hyprctl keyword monitor eDP-1,1920x1080@144,0x0,1
}


if [ "$1" == "onlysecond" ]; then
  onlysecond
elif [ "$1" == "onlyfirst" ]; then
  onlyfirst
elif [ "$1" == "extend" ]; then
  extend
elif [ "$1" == "mirror" ]; then
  mirror
fi
