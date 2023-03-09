#! /bin/bash

ISOPEN=$(eww windows | grep "*bar" | tr -d '*')


if [ "$ISOPEN" = "" ]; then
MONITOR=$(hyprctl monitors | grep -B 10 "focused: yes" | grep "ID" | awk -F '(' ' { print $2 } ' | tr -d 'ID ):')
  eww open bar
else
  eww close "$ISOPEN"
fi
