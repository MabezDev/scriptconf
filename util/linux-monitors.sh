#!/bin/zsh

# switch display to there correct inputs
# gigabyte
ddcutil -b "4" setvcp 60 "0x0f"
ddcutil -b "5" setvcp 60 "0x0f"
# benq
ddcutil -b "2" setvcp 60 "0x03"

# setup displays
xrandr --output DisplayPort-1 --set TearFree on --mode 2560x1440 --rate 165 --pos 0x0 --rotate normal --output DisplayPort-0 --set TearFree on --mode 2560x1440 --rate 165 --pos 2560x0 --rotate normal --output DisplayPort-2 --set TearFree on --primary --mode 1920x1080 --rate 60 --pos 5120x0 --rotate normal