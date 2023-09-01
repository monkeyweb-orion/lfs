#!/bin/bash
set -e
echo "Cleanup.."

# logout

# unmount VFS
umount -v $LFS/dev/pts
umount -v $LFS/dev
umount -v $LFS/run
umount -v $LFS/proc
umount -v $LFS/sys

# If multiple partitions were created, unmount the other 
# partitions before unmounting the main one, like this:
# umount -v $LFS/usr
# umount -v $LFS/home

# unmount LFS
umount -v $LFS

# Now, reboot the system with: 
# shutdown -r now