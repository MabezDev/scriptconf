#!/bin/sh

until xrandr --output DisplayPort-0 --mode 1920x1080 --pos 0x0 --rotate normal --output DVI-0 --primary --mode 1920x1080 --pos 1920x0 --rotate normal --rate 144 --output HDMI-0 --off
do
  sleep 1
done

# Finally restart i3 as it gets bugged adding and removing monitors
i3-msg restart	