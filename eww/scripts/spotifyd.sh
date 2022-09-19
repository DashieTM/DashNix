#!/bin/bash
if [ "$PLAYER_EVENT" = "start" ] || [ "$PLAYER_EVENT" = "change" ];
then
    song=$(playerctl metadata -p spotifyd --format "{{ title }}\n{{ artist }}\n{{ album }}")
    if [ ! -f "/home/dashie/.cache/icons/$song" ]; then
    thumb=$(playerctl metadata -p spotifyd --format '{{lc(mpris:artUrl)}}')
    convert "$thumb" -flatten -thumbnail 256x256 /home/dashie/.cache/icons/"$song" 
    fi
    dunstify -I /home/dashie/.cache/icons/"$song" -t 3000 "Spotify" "$song"
fi
