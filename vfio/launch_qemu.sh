#!/bin/bash

vmname="Windows-10"
cp /usr/share/edk2-ovmf/OVMF_VARS.fd /tmp/ovmf_vars.fd

# use pulseaudio
export QEMU_AUDIO_DRV=pa
export QEMU_PA_SERVER=/run/user/1000/pulse/native

# make sure vfio is loaded
/home/mabez/scripts/vfio/vfiobind.sh

qemu-system-x86_64 \
  -name $vmname,process=$vmname \
  -machine type=pc-i440fx-2.9,accel=kvm \
  -cpu host,kvm=off,hv_vendor_id=Nvidia43FIX \
  -smp 8,sockets=1,cores=8,threads=1 \
  -enable-kvm \
  -m 8G \
  -rtc clock=host,base=localtime \
  -drive if=pflash,format=raw,readonly,file=/usr/share/edk2-ovmf/OVMF_CODE.fd \
  -drive if=pflash,format=raw,file=/tmp/ovmf_vars.fd \
  -device vfio-pci,host=28:00.0 \
  -device vfio-pci,host=28:00.1 \
  -vga std \
  -soundhw hda \
  -object iothread,id=iothread0 \
  -device virtio-scsi-pci,iothread=iothread0,id=scsi -device scsi-hd,drive=hd -drive if=none,id=hd,file=/home/mabez/vfio/windows.qcow2,format=qcow2 \
  -netdev tap,id=vmnic,ifname=tap0,script=no,downscript=no \
  -device virtio-net,netdev=vmnic \
  -nographic \
  -device nec-usb-xhci -device usb-host,vendorid=0x0a12,productid=0001 -device usb-host,vendorid=0x1b1c,productid=0x1b13 -device usb-host,vendorid=0x1b1c,productid=0x1b12
  #-device -usb host:0a12:0001 \
  #-cdrom /home/mabez/xen/iso/Win10_1607_English_x64.iso \
  #-soundhw hda \
  # -device vfio-pci,host=01:00.0 \ #nvme, is now in group 0 but it wasnt before?
