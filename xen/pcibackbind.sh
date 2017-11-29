#!/bin/bash

videoid="10de 1b06"
audioid="10de 10ef"
videobusid="0000:28:00.0"
audiobusid="0000:28:00.1"

#echo $videoid > /sys/bus/pci/drivers/pciback/new_id
#echo $videobusid > /sys/bus/pci/devices/$videobusid/driver/unbind
#echo $videobusid > /sys/bus/pci/drivers/pciback/bind
#echo $videoid > /sys/bus/pci/drivers/pciback/remove_id

echo $audioid > /sys/bus/pci/drivers/pciback/new_id
echo $audiobusid > /sys/bus/pci/devices/$audiobusid/driver/unbind
echo $audiobusid > /sys/bus/pci/drivers/pciback/bind
echo $audioid > /sys/bus/pci/drivers/pciback/remove_id
