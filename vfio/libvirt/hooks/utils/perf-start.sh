#!/bin/bash

set -e

## Load the config file
source "/etc/libvirt/hooks/kvm.conf"

# change qemu to use realtime scheduling
QEMU=qemu-system-x86_64
if pid=$(pidof $QEMU); then
    chrt -f -p 1 $pid
    if [ $? = 0 ]; then
        echo "$(date) INFO: real-time scheduling SET for $QEMU pid: $pid"
    else
        echo "$(date) ERROR: real-time scheduling FAILED for $QEMU pid: $pid"
    fi
fi

# Reduce VM jitter: https://www.kernel.org/doc/Documentation/kernel-per-CPU-kthreads.txt
sysctl vm.stat_interval=120

# the kernel's dirty page writeback mechanism uses kthread workers. They introduce
# massive arbitrary latencies when doing disk writes on the host and aren't
# migrated by cset. Restrict the workqueue to use only cpu 0.
echo $HOST_CORES_MASK > /sys/bus/workqueue/devices/writeback/cpumask
echo $HOST_CORES_MASK > /sys/devices/virtual/workqueue/cpumask
echo 0 > /sys/bus/workqueue/devices/writeback/numa

# THP can allegedly result in jitter. Better keep it off.
echo never > /sys/kernel/mm/transparent_hugepage/enabled
echo never >/sys/kernel/mm/transparent_hugepage/defrag


# Make sure vfio interrupts are processes on the respective GUEST cores, i.e if core 0 in the VM initiates an interrupt, it should be handled by the GUEST cores
# Force any other IRQ's OFF of guest cores and onto host cores
set +e
grep -v vfio /proc/interrupts | cut -b 3-4 | tail -n +2 | while read -r i ; do
    if [[ -f "/proc/irq/$i/smp_affinity_list" && "$i" -ne "0" ]]; then
        echo "set core list $HOST_CORES to irq $i"
        echo "$HOST_CORES" >/proc/irq/$i/smp_affinity_list
    fi
done
set -e

grep vfio /proc/interrupts | cut -b 3-4 | tail -n +2 | while read -r i ; do
    echo "set core list $GUEST_CORES to irq $i"
    echo "$GUEST_CORES" >/proc/irq/$i/smp_affinity_list
done