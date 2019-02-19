#!/bin/bash

ON=$1
if [ "$ON" == "1" ]; then
	mount /hugepages
	sysctl vm.nr_hugepages=6144
else
	sysctl vm.nr_hugepages=0
	umount /hugepages
fi
