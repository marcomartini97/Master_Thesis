#!/bin/bash

export USERNAME=marco

podman run \
  --name weston-$USERNAME \
  --hostname weston-$USERNAME \
  --restart unless-stopped \
  -e XDG_RUNTIME_DIR=/tmp \
  -e USERNAME=$USERNAME \
  -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
  -v /tmp/dbus:/var/run/dbus \
  -v /etc/passwd:/etc/passwd:ro \
  -v /etc/group:/etc/group:ro \
  -v /home/marco:/mnt/home/marco \
  -v /etc/weston:/etc/weston:ro \
  --cap-add SYS_ADMIN \
  --cap-add NET_ADMIN \
  --cap-add SYS_PTRACE \
  --cap-add AUDIT_CONTROL \
  --security-opt seccomp=unconfined \
  --security-opt label=disable \
  --device /dev/fuse \
  --device /dev/nvidia0 \
  --device /dev/nvidiactl \
  --device /dev/nvidia-uvm \
  --device /dev/dri/renderD128 \
  fedora_dev \
  /usr/sbin/init
