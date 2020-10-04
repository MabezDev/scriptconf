#!/bin/bash

LC_ALL=en_GB.UTF-8
LANG=en_GB.UTF-8
source /home/mabez/programs/vfio-isolate/bin/activate

# limit popts to host slice + 1
popts 7

# isolate the csets and move all *non* guest processes to the host slice
vfio-isolate cpuset-create --cpus C0-5 /host.slice cpuset-create --cpus C8-15,6-7 -nlb /machine.slice move-tasks / /host.slice

# disable irq's on guest cores
vfio-isolate -u /tmp/undo_irq irq-affinity mask C6-15,6-7

# set cpu gov to performance for specific cores
vfio-isolate -u /tmp/undo_gov cpu-governor performance C6-15,6-7