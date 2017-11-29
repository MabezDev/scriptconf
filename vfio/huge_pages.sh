#!/bin/bash

ON=$1
if [ "$ON" == "1" ]; then
	sudo mount /hugepages
	sudo sysctl vm.nr_hugepages=4096
else
	sudo sysctl vm.nr_hugepages=0
	sudo umount /hugepages
fi
