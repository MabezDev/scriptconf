#!/bin/bash
# export QEMU_AUDIO_DRV=pa
# export QEMU_PA_SERVER=/run/user/1000/pulse/native
# export QEMU_PA_SINK=alsa_output.usb-C-Media_Electronics_Inc._USB_Audio_Device-00.analog-stereo
# export QEMU_PA_SOURCE=input

# stop corsair daemon so we can grab  kb and mouse for the VM
sudo systemctl stop ckb-daemon
sleep 1 # Let the corsair drivers unbind
sudo xl create ~/xen/conf/windows-lvm.cfg
sleep 1


processes=("spotify" "synergyc")
args=("" "192.168.122.98")

for (( i=0; i<${#processes[@]}; i++ ));
do
  :
  process=${processes[$i]}
  arg=${args[$i]}
  result=`pgrep ${process}`
  if [ "${result:-null}" = null ]; then
          echo -n "[Launching]: " 
          printed="$process"
          if [ ! -z "$arg" ]; then
            printed="$printed $arg"
          fi
          echo $printed
          exec $printed &
  else
          echo "[Running]: '$process'"
  fi
done


# open spice, currently only needed for sound, need to qemu to output to pulse directly
remote-viewer spice://localhost:6000

echo "Done."
