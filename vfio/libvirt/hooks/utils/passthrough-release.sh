#!/bin/bash

## Load the config file
source "/etc/libvirt/hooks/kvm.conf"

rc-service ckb-next-daemon start
killall barrierc

mount /storage

# re-enable 144hz monintor - bash magic to run this asynchronously, so we dont hang if we have switched inputs
bash -c "su mabez -c 'DISPLAY=:0 /home/mabez/scripts/util/dual_144hz.sh </dev/null &>/dev/null &; disown'"