#!/bin/bash

# This is based on hostname! Don't change it 

XDG_RUNTIME_DIR=/tmp su -c 'weston -c /etc/weston/weston.ini' $(awk -F'-' '{print $2}' /etc/hostname)
