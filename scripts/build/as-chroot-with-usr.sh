#!/bin/bash
set -e
echo "Continue with chroot environment.."

# configure system
sh /scripts/build/9.2-make-lfs-bootscripts.sh
sh /scripts/build/9.4-manage-devices.sh
sh /scripts/build/9.5-configure-network.sh
sh /scripts/build/9.6-configure-systemv.sh
sh /scripts/build/9.7-bash-shell.sh
sh /scripts/build/9.8-configure-bash.sh

# make system bootable
sh /scripts/build/10.1-create-fstab.sh
sh /scripts/build/10.3-make-linux-kernel.sh
sh /scripts/build/10.4-setup-grub.sh

# end
sh /scripts/build/11.1-the-end.sh

exit