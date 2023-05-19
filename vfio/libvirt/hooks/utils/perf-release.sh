#!/bin/bash

set -e

## Load the config file
source "/etc/libvirt/hooks/kvm.conf"

echo always > /sys/kernel/mm/transparent_hugepage/enabled
echo always >/sys/kernel/mm/transparent_hugepage/defrag

sysctl vm.stat_interval=1
sysctl -w kernel.sched_rt_runtime_us=950000

echo $TOTAL_CORES_MASK > /sys/bus/workqueue/devices/writeback/cpumask
echo $TOTAL_CORES_MASK > /sys/devices/virtual/workqueue/cpumask
echo 1 > /sys/bus/workqueue/devices/writeback/numa


# allow IRQ's to be handled on any core again
set +e # some writes may fail - ignore
cat /proc/interrupts | cut -b 3-4 | tail -n +2 | while read -r i ; do
    echo "set mask $TOTAL_CORES_MASK to irq $i"
    echo "$TOTAL_CORES_MASK" >/proc/irq/$i/smp_affinity
done
set -e