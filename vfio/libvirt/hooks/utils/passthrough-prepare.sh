#!/bin/bash

## Load the config file
source "/etc/libvirt/hooks/kvm.conf"

# Full pass throu prepare, ready for KB, display switch and extra storage

rc-service ckb-daemon stop

if df | grep -q storage; then
    umount /storage || exit 1 # dont start the VM if we fail to unmount the fs!
fi

if [[ "$(ddcutil -d "$VM_DISPLAY" getvcp 60 --terse | awk '{print $4}')" != "x$INPUT" ]]; then
    ddcutil -d "$VM_DISPLAY" setvcp 60 "0x$VM_INPUT"
fi

su mabez -c "DISPLAY=:0 xrandr --output HDMI-A-0 --off"
su mabez -c "barrierc $VM_IP"