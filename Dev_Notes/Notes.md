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
