#! /bin/bash

NUM=$(pactl list clients short | rg "ncspot" | awk -F 'PipeWire' ' { print $1 } ' | tr -d ' \t\n')
CHANGE=$(pactl list sink-inputs short | rg "$NUM" | awk -F ' ' ' { print $1 }' | tr -d ' \t\n')
pactl set-sink-input-volume "$CHANGE" "$1"
VOLUME=$(pactl list sink-inputs | rg "$NUM" -A7 | rg "Volume:" | awk -F ' ' ' { print $5 }' | tr -d '%')
dunstify -a "changeVolume" -r 2 -u low -i audio-volume-high -h int:value:"$VOLUME" "Spotify Volume: ${VOLUME}%"
