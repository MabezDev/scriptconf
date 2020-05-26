#!/bin/bash

LC_ALL=en_GB.UTF-8
LANG=en_GB.UTF-8
source /home/mabez/programs/vfio-isolate/bin/activate

# undo the isolation
vfio-isolate cpuset-delete /host.slice cpuset-delete /machine.slice

# undo
vfio-isolate restore /tmp/undo_irq
vfio-isolate restore /tmp/undo_gov