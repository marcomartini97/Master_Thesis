# Setup 

![https://gitlab.gnome.org/GNOME/gnome-remote-desktop#headless-single-user](https://gitlab.gnome.org/GNOME/gnome-remote-desktop#headless-single-user)

Uname and Pass: rdp, rdp, it doesn't matter since it's inside a closed  container

## Headless gnome

First of all eval dbus

eval "$(dbus-launch --sh-syntax)"

With --headless flag on grdctl should work fine, then activate gnome-remote-desktop-headless instead of gnome-remote-desktop

Then start gnome-shell --headless as user


## Problems:

+ Some GTK apps require vulkan -> Crashes on current driver 525.85.05 (Maybe updating will fix it?)

## Workaround vulkan

```
GSK_RENDERER=ngl
```

## Environmental variables issues

Environmental variables not passing through gnome-shell for dbus

Workaround(static on terminal):

```
export XDG_CURRENT_DESKTOP=gnome DISPLAY=:0 XAUTHORITY=/var/run/user/1000/.mutter-Xwaylandauth.<last_created>
```

### Session fix

Modify org.Gnome.Shell.desktop such that it launches gnome-shell --headless.

TODO: create own local session with org.Gnome.Shell.Headless.desktop




## Setup RDP credentials (maybe)

Need to create keyring first:

yum -y install gnome-keyring libsecret dbus-x11

eval "$(dbus-launch --sh-syntax)"

mkdir -p ~/.cache
mkdir -p ~/.local/share/keyrings # where the automatic keyring is created

### 1. Create the keyring manually with a dummy password in stdin

eval "$(printf '\n' | gnome-keyring-daemon --unlock)"

### 2. Start the daemon, using the password to unlock the just-created keyring:

eval "$(printf '\n' | /usr/bin/gnome-keyring-daemon --start)"

### Follow procedures

