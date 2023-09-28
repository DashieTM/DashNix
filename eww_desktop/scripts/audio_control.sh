#!/bin/bash

ncspot() {
	echo "$1"
	echo "$2"
	NUM=$(pactl list clients short | rg "ncspot" | awk -F 'PipeWire' ' { print $1 } ' | tr -d ' \t\n')
	CHANGE=$(pactl list sink-inputs short | rg "$NUM" | awk -F ' ' ' { print $1 }' | tr -d ' \t\n')
	pactl set-sink-input-volume "$CHANGE" "$1"
	VOLUME=$(pactl list sink-inputs | rg "$NUM" -A7 | rg "Volume:" | awk -F ' ' ' { print $5 }' | tr -d '%')
	notify-send -a "ncspot" -r 990 -u low -i audio-volume-high -h int:progress:"$VOLUME" "Spotify Volume: ${VOLUME}%"
}

firefox() {
	STRING=$(pactl list clients short | rg "firefox" | awk -F 'PipeWire' ' { print $1 "," } ' | tr -d ' \t\n')
	# NUMS=',' read -r -a array <<< "$STRING"
	readarray -td, NUMS <<<"$STRING"
	declare -p NUMS
	for index in "${!NUMS[@]}"; do #"${!array[@]}"
		NUM=$(echo "${NUMS[index]}" | tr -d ' \t\n')
		CHANGE=$(pactl list sink-inputs short | rg "$NUM" | awk -F ' ' ' { print $1 }' | tr -d ' \t\n')
		pactl set-sink-input-volume "$CHANGE" "$1"
	done
	VOLUME=$(pactl list sink-inputs | rg "${NUMS[0]}" -A7 | rg "Volume:" | awk -F ' ' ' { print $5 }' | tr -d '%')
	notify-send -a "Firefox" -r 991 -u low -i audio-volume-high -h int:progress:"$VOLUME" "Firefox Volume: ${VOLUME}%"
}

internal() {
	SPEAKER=$(pactl list sinks | grep "Name" | grep "alsa" | awk -F ': ' '{ print $2  }')
	if [ "$SPEAKER" != "" ]; then
		pactl set-default-sink "$SPEAKER"
		pactl set-sink-mute "$SPEAKER" false
		DEVICE=$(echo "$SPEAKER" | awk -F '.' ' { print $4 } ')
		notify-send "changed audio to "$DEVICE" "
	else
		notify-send "failed, not available!"
	fi
}

set_volume_sink() {
	pactl set-sink-volume @DEFAULT_SINK@ "$1"
	CURRENT=$(pactl get-sink-volume @DEFAULT_SINK@ | awk -F'/' '{ print $2 }' | tr -d ' %')
	notify-send -a "System Volume" -r 993 -u low -i audio-volume-high -h int:progress:"$CURRENT" "Output Volume: ${CURRENT}%"
}

set_volume_source() {
	pactl set-source-volume @DEFAULT_SOURCE@ "$1"
	CURRENT=$(pactl get-source-volume @DEFAULT_SOURCE@ | awk -F'/' '{ print $2 }' | tr -d ' %')
	notify-send -a "System Volume" -r 993 -u low -i audio-volume-high -h int:progress:"$CURRENT" "Input Volume: ${CURRENT}%"
}

bluetooth() {
	SPEAKER=$(pactl list sinks | grep "Name" | grep "blue" | awk -F ': ' '{ print $2  }')
	if [ "$SPEAKER" != "" ]; then
		pactl set-default-sink "$SPEAKER"
		pactl set-sink-mute "$SPEAKER" false
		DEVICE=$(echo "$SPEAKER" | awk -F '.' ' { print $4 } ')
		notify-send "changed audio to "$DEVICE" "
	else
		notify-send "failed, not available!"
	fi
}

mute() {
	pactl set-sink-mute @DEFAULT_SINK@ toggle
	MUTE=$(pactl get-sink-mute @DEFAULT_SINK@)
	notify-send -a "Audio" -r 994 -u low -i audio-volume-high "Audio: $MUTE"
}

if [ "$1" == "internal" ]; then
	internal
elif [ "$1" == "bluetooth" ]; then
	bluetooth
elif [ "$1" == "firefox" ]; then
	firefox "$2"
elif [ "$1" == "ncspot" ]; then
	ncspot "$2"
elif [ "$1" == "mute" ]; then
	mute
elif [ "$1" == "sink" ]; then
	set_volume_sink "$2"
elif [ "$1" == "source" ]; then
	set_volume_source "$2"
fi
