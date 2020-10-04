#!/bin/bash

## Load the config file
source "/etc/libvirt/hooks/kvm.conf"

sysctl vm.stat_interval=1

echo always > /sys/kernel/mm/transparent_hugepage/enabled
echo always >/sys/kernel/mm/transparent_hugepage/defrag

sysctl vm.stat_interval=1

echo $TOTAL_CORES_MASK > /sys/bus/workqueue/devices/writeback/cpumask
echo $TOTAL_CORES_MASK > /sys/devices/virtual/workqueue/cpumask
