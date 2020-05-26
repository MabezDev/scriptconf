#!/bin/bash

## Load the config file
source "/etc/libvirt/hooks/kvm.conf"

sysctl vm.stat_interval=1
sysctl -w kernel.watchdog=1
echo always > /sys/kernel/mm/transparent_hugepage/enabled
echo always >/sys/kernel/mm/transparent_hugepage/defrag
echo ondemand | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
echo 1 > /sys/bus/workqueue/devices/writeback/numa
echo $TOTAL_CORES_MASK > /sys/bus/workqueue/devices/writeback/cpumask
echo $TOTAL_CORES_MASK > /sys/devices/virtual/workqueue/cpumask
