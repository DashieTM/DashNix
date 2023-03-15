#!/usr/bin/env python3

import os
import socket

# Replace "your_user" with the actual username of the logged-in user.
USER = "dashie"

def execute_script(event):
    # This function executes the script file as the specified user.
    os.system(f"/home/dashie/.config/eww/scripts/auto_dock.sh {event}")

# Create a socket object and connect to the acpid socket.
sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
sock.connect("/var/run/acpid.socket")

# Listen for events and execute the script file.
while True:
    data = sock.recv(1024).decode()
    if "button/lid" in data:
        event = data.split()[-1]
        execute_script(event)

