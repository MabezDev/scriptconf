#!/bin/bash

## Load the config file
source "/etc/libvirt/hooks/kvm.conf"

fbdev=$(grep -o "PCI:\*\((.*)\)" /var/log/Xorg.0.log)

# TODO hardcoded, can we figure out the address of the card we are passing through? - `lspci -n | grep 10de:2206 | cut -d' ' -f1` gives us close, but not quite right format
if [[ "$fbdev" == "PCI:*(10@0:0:0)" ]]; then
    echo "INFO - EFI FrameBuffer is bound to device we are trying to pass"
    # unbind the framebuffer if required
    if test -e "/sys/bus/platform/devices/efi-framebuffer.0/driver"; then
        echo "Unbinding EFI framebuffer..."
        echo "efi-framebuffer.0" > /sys/bus/platform/devices/efi-framebuffer.0/driver/unbind
    fi
fi

