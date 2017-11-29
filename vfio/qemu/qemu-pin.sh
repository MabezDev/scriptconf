#!/bin/bash

processname="windows"
numvcpu=8
phycpu=8 # start on core 8

QEMU_PIDS=$(ps -Leo tid,%cpu,args | grep qemu | grep $processname | grep -v grep | sort -k 2 -rn | sed "s/^ *\([0-9]*\).*/\1/" |
head -$numvcpu)

echo $QEMU_PIDS

for pid in $QEMU_PIDS
do
    echo "Assiging $pid to $phycpu"
    taskset -pc $phycpu $pid;
    phycpu=$((phycpu+1))
done
