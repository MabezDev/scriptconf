#!/bin/bash

## Load the config file
source "/etc/libvirt/hooks/kvm.conf"

# change qemu to use realtime scheduling
QEMU=qemu-system-x86_64
if pid=$(pidof $QEMU); then
    chrt -f -p 1 $pid
    if [ $? = 0 ]; then
        echo "$(date) INFO: real-time scheduling SET for $QEMU pid: $pid"
    else
        echo "$(date) ERROR: real-time scheduling FAILED for $QEMU pid: $pid"
    fi
fi
