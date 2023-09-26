#!/bin/bash

set -e

## Load the config file
source "/etc/libvirt/hooks/kvm.conf"

if df | grep -q storage; then
    umount /storage || exit 1 # dont start the VM if we fail to unmount the fs!
fi