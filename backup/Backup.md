1) Grab a Live USB (Arch cuz arch-chroot)
2) Put the latest full sys backup on the disk
3) Mount disks (eg):
	/mnt/gentoo
	/mnt/gentoo/boot
	/mnt/gentoo/home
   And enable swap
4) Edit /mnt/gentoo/etc/fstab to use the correct UUID for the partitions
5) Chroot with arch-chroot /mnt/gentoo or manually
5a) This will require folders like /proc to be made, for prooper chrooting
6) Refresh the grub just incase
7) If there are any HW changes make sure Kernel is configured correctly
8) exit, unmount and reboot into the backup!

