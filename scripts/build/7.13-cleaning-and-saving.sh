#!/bin/bash
set -e
echo "Cleaning up and saving the temporary system ..."

# Cleaning
rm -rf /usr/share/{info,man,doc}/*
find /usr/{lib,libexec} -name \*.la -delete

# rm -rf /tools

# 7.13.2. Backup
# exit

# umount $LFS/dev/pts
# umount $LFS/{sys,proc,run,dev}

# cd $LFS
# tar -cJpf $HOME/lfs-temp-tools-11.2.tar.xz .

# 7.13.3. Restore
# cd $LFS
# rm -rf ./*
# tar -xpf $HOME/lfs-temp-tools-11.2.tar.xz