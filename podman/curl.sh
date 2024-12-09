curl --unix-socket /run/podman/podman.sock -X POST -H "Content-Type: application/json" -d '
{
    "name": "weston-marco",
    "hostname": "weston-marco",
    "image": "fedora_dev",
    "cap_add": [
      "SYS_ADMIN",
      "NET_ADMIN",
      "SYS_PTRACE",
      "AUDIT_CONTROL"
    ],
    "devices": [
      {
        "path": "/dev/fuse"
      },
      {
        "path": "/dev/nvidia0"
      },
      {
        "path": "/dev/nvidiactl"
      },
      {
        "path": "/dev/nvidia-uvm"
      },
      {
        "path": "/dev/dri/renderD128"
      }
    ],
    "env": {
      "XDG_RUNTIME_DIR": "/tmp",
      "USERNAME": "marco"
    },
    "mounts":[
        {
                "Source": "/etc/weston",
                "Destination": "/etc/weston",
                "Type": "bind",
                "ReadOnly": true
        },
      {
        "Source": "/etc/passwd",
        "Destination": "/etc/passwd",
        "Type": "bind",
        "ReadOnly": "true"
      },
      {
        "Source": "/etc/group",
        "Destination": "/etc/group",
        "Type": "bind",
        "ReadOnly": "true"
      },
      {
        "Source": "/etc/shadow",
        "Destination": "/etc/shadow",
        "Type": "bind",
        "ReadOnly": "true"
      }

    ],
    "command": ["/usr/sbin/init"]
}
' http://d/v5.3.0/libpod/containers/create

