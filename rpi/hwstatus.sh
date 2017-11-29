#!/bin/bash

# CPU Temp
now="[`date +%H:%M:%S`] Probing hardware..."
echo "$now"
echo ""
echo "[Temperatures]"
echo -n "CPU: "
awk '{printf "%3.1f°C\n", $1/1000}' /sys/class/thermal/thermal_zone0/temp
echo ""
echo "[System Info]"
echo ""
echo "RAM Usage(Mb):"
free -m
echo ""
echo "Storage: dev | total | used | free | % | mount point"
df -h | grep mmcblk
