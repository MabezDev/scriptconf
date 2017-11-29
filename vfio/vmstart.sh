#!/bin/bash

vmname="win10Q35"

processes=("spotify" "synergyc")
args=("" "192.168.122.78")

for (( i=0; i<${#processes[@]}; i++ ));
do
  :
  process=${processes[$i]}
  arg=${args[$i]}
  result=`pgrep ${process}`
  if [ "${result:-null}" = null ]; then
          echo -n "[Launching]: " 
          cmd="$process"
          if [ ! -z "$arg" ]; then # if no
            cmd="$printed $arg"
          fi
          echo $cmd
          exec $cmd & # exec as a sub process
  else
          echo "[Running]: '$process'"
  fi
done

isRunning=$(sudo virsh -c qemu:///system list --all | grep "$vmname" |  awk '{ print $3}')
if ([ $isRunning == "running" ]) then
	echo "$vmname is already running!"
else
	echo "Launching $vmname"
  sudo systemctl stop ckb-daemon # tempory whilst I dont pass through a USB controller
	sudo virsh -c qemu:///system start $vmname
fi
