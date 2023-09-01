#!/bin/bash
echo "Preparing Virtual Kernel File Systems.."

# 7.3. Preparing Virtual Kernel File Systems
# create directories onto which the file systems will be mounted
mkdir -pv $LFS/{dev,proc,sys,run}

# 7.3.1. Mounting and Populating /dev
# mount and populate /dev
mount -v --bind /dev $LFS/dev

# 7.3.2. Mounting Virtual Kernel File Systems
# mount Virtual Kernel File Systems
mount -v --bind /dev/pts $LFS/dev/pts
mount -vt proc proc $LFS/proc
mount -vt sysfs sysfs $LFS/sys
mount -vt tmpfs tmpfs $LFS/run

if [ -h $LFS/dev/shm ]; then
    mkdir -pv $LFS/$(readlink $LFS/dev/shm)
fi