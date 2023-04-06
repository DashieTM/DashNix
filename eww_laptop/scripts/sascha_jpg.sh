#!/bin/sh 

MONITOR=$(hyprctl monitors | grep "ID 1" | awk '{print ($2)}')
echo MONITOR

extend() {
  hyprctl keyword wsbind 1, 
  hyprctl keyword wsbind 2, 
  hyprctl keyword wsbind 3, 
  hyprctl keyword wsbind 4, 
  hyprctl keyword wsbind 5, 
  hyprctl keyword wsbind 6, 
  hyprctl keyword wsbind 7, 
  hyprctl keyword wsbind 8, 
  hyprctl keyword wsbind 9, 
  hyprctl keyword wsbind 10,eDP-1
}
retract() {
  hyprctl keyword wsbind 1,eDP-1
  hyprctl keyword wsbind 2,eDP-1
  hyprctl keyword wsbind 3,eDP-1
  hyprctl keyword wsbind 4,eDP-1
  hyprctl keyword wsbind 5,eDP-1
  hyprctl keyword wsbind 6,eDP-1
  hyprctl keyword wsbind 7,eDP-1
  hyprctl keyword wsbind 8,eDP-1
  hyprctl keyword wsbind 9,eDP-1
  hyprctl keyword wsbind 10,eDP-1 
}
if [ "$1" == "extend" ]; then
  extend
elif [ "$1" == "retract" ]; then
  retract
fi
