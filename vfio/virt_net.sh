#!/bin/bash


if ! ip link show br0 ; then
	modprobe tun

	ip link add br0 type bridge
	ip link set dev enp6s0 master br0

	rc-service net.br0 start

	ip tuntap add dev tap0 mode tap
	ip link set tap0 up promisc on
	brctl addif br0 tap0
fi

