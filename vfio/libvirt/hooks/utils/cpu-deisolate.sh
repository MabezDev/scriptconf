#!/bin/bash

set -e

LC_ALL=en_GB.UTF-8
LANG=en_GB.UTF-8
source /home/mabez/programs/vfio-isolate/bin/activate

# restore to full make opts
popts 17

# undo the isolation
vfio-isolate cpuset-delete /host.slice
vfio-isolate cpuset-delete /emu.slice
vfio-isolate cpuset-delete /machine.slice

# undo
vfio-isolate restore /tmp/undo_irq
vfio-isolate restore /tmp/undo_gov