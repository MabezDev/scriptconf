#!/bin/bash

set -e

LC_ALL=en_GB.UTF-8
LANG=en_GB.UTF-8

source /home/mabez/programs/vfio-isolate/bin/activate

## Load the config file
source "/etc/libvirt/hooks/kvm.conf"

# limit popts to host slice + 1
popts 7

# isolate the csets and move all *non* guest processes to the host slice
vfio-isolate cpuset-create --cpus C$HOST_CORES /host.slice cpuset-create --cpus C$EMULATOR_CORES -nlb /emu.slice cpuset-create --cpus C$GUEST_CORES -nlb /machine.slice move-tasks / /host.slice

# disable irq's on guest cores
vfio-isolate -u /tmp/undo_irq irq-affinity mask C$GUEST_CORES,$EMULATOR_CORES

# set cpu gov to performance for specific cores
vfio-isolate -u /tmp/undo_gov cpu-governor performance C$GUEST_CORES,$EMULATOR_CORES