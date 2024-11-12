# NVIDIA module on LXC

This step will install the NVIDIA module on LXC.
First of all, install the same module version on proxmox and the client.
Then, bind the correct files through the lxc config file.

lxc.cgroup.devices.allow: c 195:* rwm
lxc.cgroup.devices.allow: c 235:* rwm
lxc.cgroup.devices.allow: c 238:* rwm
lxc.mount.entry: /dev/nvidia0 dev/nvidia0 none bind,optional,create=file
lxc.mount.entry: /dev/nvidiactl dev/nvidiactl none bind,optional,create=file
lxc.mount.entry: /dev/nvidia-uvm dev/nvidia-uvm none bind,optional,create=file
#lxc.mount.entry: /dev/nvidia-modeset dev/nvidia-modeset none bind,optional,create=file
lxc.mount.entry: /dev/nvidia-uvm-tools dev/nvidia-uvm-tools none bind,optional,create=file
lxc.mount.entry: /dev/nvidia-uvm-tools dev/nvidia-caps/nvidia-cap1 none bind,optional,create=file
lxc.mount.entry: /dev/nvidia-uvm-tools dev/nvidia-caps/nvidia-cap2 none bind,optional,create=file

# Rendering Device

Since we want to use the DRM device for wayland, we need to bind the correct files.

lxc.cgroup.devices.allow: c 226:* rwm
lxc.mount.entry: /dev/dri/renderD129 dev/dri/renderD129 none bind,optional,create=file 0, 0

Note, that the permissions are still wrong. So from proxmox we need to set it to 666.

SO (replace gid with the group on the container)


## DO NOT! 

don't mount neither 

lxc.mount.entry: /dev/dri dev/dri none bind,optional,create=dir

nor the card enumerator, for some reason EGL does not work with this

lxc.mount.entry: /dev/dri/card0 dev/dri/card0 none bind,optional,create=file


lxc.cgroup2.devices.allow = c 226:* rwm

# Nvidia

When using nvidia, install with --no-kernel-module

Note: new driver is great https://forums.developer.nvidia.com/t/wayland-support-for-the-565-release-series/312688

# Docker

We need to connect docker containers to the RFX network -> macvlan

```
docker network create -d macvlan \
  -o parent=eth0 rfx_net 
```

But can't do DHCP -> discard for Podman instead

# Podman

## Network

### DHCP macvlan

https://www.redhat.com/en/blog/leasing-ips-podman

Notes:

On arch linux /usr/libexec/cni/dhcp is actually /usr/lib/cni/dhcp

The service is called cni-dhcp.service

also need netavark-dhcp-proxy

#### DHCP bridge

Just use bridge with parent eth0

#### Isolated <- current solution

We use isolated networks and do port forwarding if needed

## Weston

Install weston, libdisplay-info 

## Podman compose

Same as docker but device gpu is a bit different

## Nvidia

After installing container toolkit:

`podman run --device nvidia.com/gpu=all`

For some reason /dev/dri/renderD128 is already there?

After installing xorg libraries, replace link for `/usr/lib/libGLX_indirect.so.0` from mesa to nvidia GLX

## Overlayfs 

Nesting problem?

Error: configure storage: kernel does not support overlay fs: kernel returned unlinkat /var/lib/containers/storage/overlay/compat4015777431/merged/subdir: invalid argument when we tried to delete an item in the merged directory: driver not supported

## User passthrough

https://pawitp.medium.com/syncing-host-and-container-users-in-docker-39337eff0094

## Cgroups-v1 to Cgroups-v2

cgroups-v1 is deprecated, need to change kernel args for cgroups-v2

# Proxmox LCX Container full?

pct resize 100 rootfs +5G
