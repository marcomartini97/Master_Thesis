# Trial 1 XVFB + PRIME OFFload<- works

From 

`/etc/X11/Xwrapper.config`

set

`allowed_users = anybody`

so that normal users without access to a physical console can start a Xorg server

Command for xvfb

xvfb-run -s "-screen 0 1920x1080x24" -f .Xauthority -d mate-session


# Step 2 Xorg with Dummy and PRIME <- works

```
Section "Device"
    Identifier "DummyDevice"
    Driver "dummy"
    VideoRam 256000
EndSection

Section "Monitor"
    Identifier "DummyMonitor"
    HorizSync 28-80
    VertRefresh 48-75
EndSection

Section "Screen"
    Identifier "DummyScreen"
    Device "DummyDevice"
    Monitor "DummyMonitor"
    DefaultDepth 24
    SubSection "Display"
        Depth 24
        Modes "1920X1080"
    EndSubSection
EndSection

Section "ServerLayout"
    Identifier "DummyLayout"
    Screen "DummyScreen"
EndSection
```

```
export __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia
```

Note: This crashes apps after doing a glxinfo -B for some reason.

# Step 3 XWAYLAND-RUN TBD

Listings

https://lists.freedesktop.org/archives/wayland-devel/2023-November/043329.html

Gitlab page

https://gitlab.freedesktop.org/ofourdan/xwayland-run

With cage (kiosk for wayland)

https://www.hjdskes.nl/projects/cage/

After setting up a container with renderD129 working and stuff with correct permissions we can use it with cage:

Install cage with xwayland support.

Run for a glxinfo

`xwfb-run -f ~/.Xauthority -s \\-geometry -s 1920x1080  -c cage -- glxinfo -B`

Note: to authenticate clients like x11vnc with this you must use the environment variable XAUTHORITY

## Mate Session

`XAUTHORITY=~/.Xauthority GDK_BACKEND=x11 xwfb-run -f ~/.Xauthority -s \\-geometry -s 1920x1080  -c cage -- mate-session`

## Problem: xwaylandrun is missing:

ModuleNotFoundError: No module named 'wlheadless'

## Problem: nvidia_drm modeset not set -> no wayland

Test verified through:

`WLR_BACKENDS=headless cage 'glxinfo -B'`

N.B: Fallisce anche con modeset peró con xwfb no


# Remote Desktop

NoMachine -> ???
x2go -> cloning
xrdp (different backends) -> ???
spice -> x11spice
vnc -> x11vnc
