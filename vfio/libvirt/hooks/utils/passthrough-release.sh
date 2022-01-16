#!/bin/bash

set -e

## Load the config file
source "/etc/libvirt/hooks/kvm.conf"

rc-service ckb-next-daemon start
killall barrierc

mount /storage

# add a timeout here, so that if the monitors are not connected we don't block libvirt from cleaning up
set +e
bash -c "timeout --preserve-status 10 su mabez -c 'DISPLAY=:0 /home/mabez/scripts/util/linux-monitors.sh && DISPLAY=:0 i3-msg restart'"
set -e