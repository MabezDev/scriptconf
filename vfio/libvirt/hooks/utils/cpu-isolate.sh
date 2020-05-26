#!/bin/bash

LC_ALL=en_GB.UTF-8
LANG=en_GB.UTF-8
source /home/mabez/programs/vfio-isolate/bin/activate

# isolate the csets and move all *non* guest processes to the host slice
vfio-isolate cpuset-create --cpus C0-7 /host.slice cpuset-create --cpus C8-15 -nlb /machine.slice move-tasks / /host.slice

# disable irq's on guest cores
vfio-isolate -u /tmp/undo_irq irq-affinity mask C8-15

# set cpu gov to performance for all cores
vfio-isolate -u /tmp/undo_gov cpu-governor performance C0-15