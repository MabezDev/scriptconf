#!/bin/sh

# Allow use to use outputs from other card
xrandr --setprovideroutputsource 1 0

until xrandr --output DisplayPort-1-1 --set TearFree on --mode 2560x1440 --rate 144 --pos 0x0 --rotate normal --output HDMI-A-0 --set TearFree on --mode 2560x1440 --rate 144 --pos 2560x0 --rotate normal --output DVI-D-0 --set TearFree on --primary --mode 1920x1080 --rate 144 --pos 5120x0 --rotate normal
do
  sleep 1
done

# load monitor info
source "/etc/libvirt/hooks/kvm.conf"
if [[ "$(ddcutil -b "$VM_DISPLAY" getvcp 60 --terse | awk '{print $4}')" != "x$INPUT" ]]; then
    ddcutil -b "$VM_DISPLAY" setvcp 60 "0x$HOST_INPUT"
fi

i3-msg restart > /dev/null 2>&1