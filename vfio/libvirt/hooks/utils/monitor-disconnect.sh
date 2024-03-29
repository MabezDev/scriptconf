#!/bin/bash

set -e

## Load the config file
source "/etc/libvirt/hooks/kvm.conf"

if [[ "$(ddcutil -b "$VM_DISPLAY" getvcp 60 --terse | awk '{print $4}')" != "x$INPUT" ]]; then
    ddcutil -b "$VM_DISPLAY" setvcp 60 "0x$VM_INPUT"
fi