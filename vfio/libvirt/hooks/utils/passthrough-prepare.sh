#!/bin/bash

## Load the config file
source "/etc/libvirt/hooks/kvm.conf"

# unbind the framebuffer
echo "Unbinding EFI framebuffer..."
echo "efi-framebuffer.0" > /sys/bus/platform/devices/efi-framebuffer.0/driver/unbind

# Full pass throu prepare, ready for KB, display switch and extra storage

rc-service ckb-next-daemon stop

if df | grep -q storage; then
    umount /storage || exit 1 # dont start the VM if we fail to unmount the fs!
fi

su mabez -c "barrierc $VM_IP"