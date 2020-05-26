#!/bin/bash

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
sysctl -w kernel.watchdog=0
# the kernel's dirty page writeback mechanism uses kthread workers. They introduce
# massive arbitrary latencies when doing disk writes on the host and aren't
# migrated by cset. Restrict the workqueue to use only cpu 0.
echo $HOST_CORES_MASK > /sys/bus/workqueue/devices/writeback/cpumask
echo $HOST_CORES_MASK > /sys/devices/virtual/workqueue/cpumask
# THP can allegedly result in jitter. Better keep it off.
echo never > /sys/kernel/mm/transparent_hugepage/enabled
echo never >/sys/kernel/mm/transparent_hugepage/defrag
