# Notes

# Louvre

## Headless Graphics Backend

DRM below

https://github.com/CuarzoSoftware/Louvre/blob/99b21bf7af0231dd4bbe028d01207a7b4d930550/src/backends/graphic/DRM/LGraphicBackendDRM.cpp#L946

It loads by loading the .so library through LCompositorPrivate

When it does it calls getAPI from the chosen library (for example through environmental variable `LOUVRE_GRAPHIC_BACKEND=headless`)

This overloads all the methods from LCompositorPrivate so you won't find direct references from the code, be careful.

### First failed call

The backend successfully starts until LCompositor::addOutput.

Unsure how the backend wayland actually creates outputs.

### Backend Choice

By default, Louvre tries to load the Wayland backend if `WAYLAND_DISPLAY` is set, and then the DRM backend if fails.

## Input Backend

https://github.com/CuarzoSoftware/Louvre/blob/99b21bf7af0231dd4bbe028d01207a7b4d930550/src/backends/input/Libinput/LInputBackendLibinput.cpp#L592

It seems that by default it wants to have a wayland backend if `WAYLAND_DISPLAY` is set, if not specified it will deinitialize everything before trying to load the Graphic backend

# Weston

## RDP Backend

### FreeRDP Proxy and no image

With freeRDP proxy while the connection seems successful there's no image.

When trying redemption, weston complains about SurfaceCommands not being supported by the client, probably need to send bitmap updates instead (shouldn't be a problem for the performance degradation since the proxy is in a local network anyways).

**Fixed by adding callbacks to proxied SurfaceCommands**

### FreeRDP Proxy and clipboard

As long as passthrough is disabled it works

### Slow mouse on Windows 11

For some reason it seems to buffer mouse inputs every 100ms, but only on Windows 11.

Using the Windows 10 client works correctly, using freeRDP client works correctly.

Seeing an issue on reddit: ![Link](https://www.reddit.com/r/WindowsHelp/comments/1fbomdt/windows_11_rdp_very_slow_compared_to_windows_10/?rdt=53426) and following the xrdp fron neutrinolabs release, it seems it's about the new GFX pipeline on RDP 8.0 or something


# RDP

FreeRDP Developer Manual -> useless

ChatGPT -> useless

Weston implementation -> ???

KRDP -? can work but limited

Forking freerdp-proxy?

## Cert generation

![Cert generation](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/8/html/securing_networks/creating-and-managing-tls-keys-and-certificates_securing-networks#creating-a-private-key-and-a-csr-for-a-tls-server-certificate-using-openssl_creating-and-managing-tls-keys-and-certificates`)

## Clion not debugging

Set the working directory to the project root not the executable root

# Redemption

Instead of freerdp-proxy use redemption as a base, note to compile bjam might not be available, just use b2, instead of hyperscan use vectorscan (provides same include files)

Too complicated -> doesn't work for some reason, can connect by setting RemoteFX but black screen
