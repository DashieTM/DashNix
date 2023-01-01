#! /bin/bash

NUM=$(pactl list clients short | grep "firefox" | awk -F 'PipeWire' ' { print $1 } ' | tr -d ' \t\n')
CLIENT=$(pactl list sink-inputs short | grep "$NUM" | awk -F ' ' ' { print $1 }' | tr -d ' \t\n')
pactl set-sink-input-volume "$CLIENT" "$1"
