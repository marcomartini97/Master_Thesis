#!/bin/bash

# This is based on hostname! Don't change it 
setup_grd.sh
su -c '(
    /usr/libexec/gnome-remote-desktop-daemon --headless &
    gnome-session
)' $(awk -F'-' '{print $2}' /etc/hostname)

