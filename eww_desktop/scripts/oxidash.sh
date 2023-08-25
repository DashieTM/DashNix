#!/bin/bash

ID=$(pgrep oxidash-gtk)

if [ "$ID" != "" ]; then
  killall oxidash-gtk
else
  oxidash-gtk
fi
