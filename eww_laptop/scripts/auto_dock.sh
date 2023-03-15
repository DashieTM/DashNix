#!/bin/bash

bat=/sys/class/power_supply/BAT0/
char="$(cat "$bat/status")"
monitor_count=$(hyprctl monitors | rg "ID 1")
internal_active=$(hyprctl monitors | rg "eDP-1")


close() {
if [ "$char" == "Discharging" ]; then 
  # dunstify 'discharging and locking'
  playerctl --all-players -a pause 
  swaylock -c 000000 & systemctl suspend
else 
  if [ "$monitor_count" == "" ]; then 
    # dunstify 'charging but no second monitor, locking'
    playerctl --all-players -a pause 
    swaylock -c 000000 & systemctl suspend
  else
  dunstify 'charging and second monitor, switching to external mode'
    ./monitor.sh onlysecond
  fi
fi
}

open() {
  if [ "$internal_active" == "" ]; then
      if [ "$monitor_count" == "" ]; then
        dunstify 'external monitor connected, extending'
        ./monitor.sh extend 
      else 
        dunstify 'only internal'
        ./monitor.sh onlyfirst
      fi 
  fi
}


if [ "$1" == "open" ]; then
  open
else 
  close
fi



