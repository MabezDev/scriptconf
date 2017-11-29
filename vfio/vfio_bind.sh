#!/bin/bash

# gfx (1080ti)
videoid="10de 1b06"
audioid="10de 10ef"
videobusid="0000:08:00.0"
audiobusid="0000:08:00.1"

echo $videoid > /sys/bus/pci/drivers/vfio-pci/new_id
echo $videobusid > /sys/bus/pci/devices/$videobusid/driver/unbind
echo $videobusid > /sys/bus/pci/drivers/vfio-pci/bind
echo $videoid > /sys/bus/pci/drivers/vfio-pci/remove_id

echo $audioid > /sys/bus/pci/drivers/vfio-pci/new_id
echo $audiobusid > /sys/bus/pci/devices/$audiobusid/driver/unbind
echo $audiobusid > /sys/bus/pci/drivers/vfio-pci/bind
echo $audioid > /sys/bus/pci/drivers/vfio-pci/remove_id

# nvme drive
nvmebusid="0000:01:00.0"
nvmeid="144d a804"
echo $nvmeid > /sys/bus/pci/drivers/vfio-pci/new_id
echo $nvmebusid > /sys/bus/pci/devices/$nvmebusid/driver/unbind
echo $nvmebusid > /sys/bus/pci/drivers/vfio-pci/bind
echo $nvmeid > /sys/bus/pci/drivers/vfio-pci/remove_id
