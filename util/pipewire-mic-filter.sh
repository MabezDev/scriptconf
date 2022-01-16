#!/bin/zsh

# start pipewire 
/usr/bin/gentoo-pipewire-launcher

# sleep 1

# pipewire/pulse takes time to start, keep trying to load the module until it succeeds
# until pactl list short sources | grep "NoiseTorch Microphone"
# do
noisetorch -i alsa_input.usb-0c76_USB_PnP_Audio_Device-00.pro-input-0 -t 10
# sleep 0.25
# done