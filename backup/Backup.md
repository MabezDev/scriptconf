1) Create an ISO with the backup: `mkisofs -iso-level 3 -o backup.iso backup/`, where `backup/` contains the backup
2) Grab any Live USB and boot from it.
3) You may which to enabled ssh and work remotely for convenience.
4) Format the new disk with appropriate partitions - see fstab in backup for reference
5) Make boot partion of type `vfat`, and other paritions of type `ext4`
6) Mount disks (eg):
   -	`/mnt/gentoo`
   -	`/mnt/gentoo/boot`
   -	`/mnt/gentoo/home`
   -    `Enable swap`
7) With all partitions mounted and formatted, extract the backup over the root file system
8) `tar -xvpzf /path/to/backup.tar.gz -C /mnt/gentoo --numeric-owner`
9) Edit /mnt/gentoo/etc/fstab to use the correct UUID for the partitions
10) Chroot with `arch-chroot /mnt/gentoo` or manually
   - This will require folders like /proc to be made, for prooper chrooting
   - This should take of everything: `for f in dev dev/pts proc sys; do mkdir -p /mnt/gentoo/$f; mount --rbind /$f /mnt/gentoo/$f ; done`
   - Finally chroot with `chroot /mnt/gentoo`
11) Refresh the grub
12) If there are any HW changes make sure Kernel is configured correctly
13) exit, unmount and reboot into the backup!

