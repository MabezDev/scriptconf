#!/bin/bash

videobusid="0000:28:00.0"
audiobusid="0000:28:00.1"
videoid="10de 1b06"
audioid="10de 10ef"

#echo 1 > /sys/bus/pci/devices/$videobusid/remove
#echo 1 > /sys/bus/pci/devices/$audiobusid/remove
#echo 1 > /sys/bus/pci/rescan

#echo -n $videoid > /sys/bus/pci/drivers/pciback/unbind

#echo $videoid > /sys/bus/pci/devices/$videoid/driver/unbind
# This works below
#echo -n 0000:28:00.0 > /sys/bus/pci/devices/0000:28:00.0/driver/unbind
#echo $videoid > /sys/bus/pci/drivers/nvidia_drm/new_id

echo -n 0000:28:00.0 > /sys/bus/pci/devices/0000:28:00.0/driver/unbind
echo -n 0000:28:00.1 > /sys/bus/pci/devices/0000:28:00.1/driver/unbind

# nvidia-cuda-mps-server
# sudo nvidia-modprobe
#modprobe nvidia
#modprobe nvidia_modeset
#modprobe nvidia_drm

#modprobe snd_hda_intel