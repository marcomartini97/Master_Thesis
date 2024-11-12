# Creating a docker 

Note:

-e environment variable

-v bind mount a volume

--device to bind mount a device: 

docker create -e XDG_RUNTIME_DIR=/tmp -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY -v $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:/tmp/$WAYLAND_DISPLAY --name wayland-docker --device /dev/dri/renderD128:/dev/dri/renderD128:rwm archlinux

docker start wayland-docker

docker attach wayland-docker

// Enable EPEL for fedora based
 
install weston

