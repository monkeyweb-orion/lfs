#!/bin/bash
set -e
echo "Using GRUB to setup the boot process.."

echo "NOTE: skipped. Check 8.4 chapter of LFS book for details"

# 10.4.1. Introduction
#
# Warning
#
# Configuring GRUB incorrectly can render your system inoperable without an alternate boot device such as a
# CD-ROM or bootable USB drive. This section is not required to boot your LFS system. You may just want
# to modify your current boot loader, e.g. Grub-Legacy, GRUB2, or LILO.
#
#cd /tmp
#grub-mkrescue --output=grub-img.iso
#xorriso -as cdrecord -v dev=/dev/cdrw blank=as_needed grub-img.iso

# install GRUB
grub-install /dev/sdb

# create grub config
cat > /boot/grub/grub.cfg << "EOF"
# Begin /boot/grub/grub.cfg
set default=0
set timeout=5

insmod ext2
set root=(hd0,1)

menuentry "GNU/Linux, Linux 5.19.2-lfs-11.2" {
    linux /boot/vmlinuz-5.19.2-lfs-11.2 root=/dev/sda1 ro
}
EOF
