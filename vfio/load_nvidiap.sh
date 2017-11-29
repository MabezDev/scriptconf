#!/bin/bash

## load_nvidia

echo "The following script will restart the X server. Remember to save your work!"
echo "Do you want to continue? [y/n]: "

modprobe nvidia
modprobe nvidia_modeset
modprobe nvidia_drm