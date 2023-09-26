#!/bin/bash

# gfx (1080ti)
#videoid="10de 1b06"
#audioid="10de 10ef"
#videobusid="0000:08:00.0"
#audiobusid="0000:08:00.1"

videoid="10de 2206"
audioid="10de 1aef"
videobusid="0a:00.0"
audiobusid="0a:00.1"

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

# usb drive
#usbbusid="0000:09:00.3"
#usbid="1022 145c"
#echo $usbid > /sys/bus/pci/drivers/vfio-pci/new_id
#echo $usbbusid > /sys/bus/pci/devices/$usbbusid/driver/unbind
#echo $usbbusid > /sys/bus/pci/drivers/vfio-pci/bind
#echo $usbid > /sys/bus/pci/drivers/vfio-pci/remove_id
