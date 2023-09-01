#!/bin/bash
set -e
echo "Building Coreutils.."
echo "Approximate build time: 0.6 SBU"
echo "Required disk space: 163 MB"

# 6.5. The Coreutils package contains utilities for 
# showing and setting the basic system characteristics.

tar -xf coreutils-*.tar.xz -C /tmp/ \
    && mv /tmp/coreutils-* /tmp/coreutils \
    && pushd /tmp/coreutils

# Prepare Coreutils for compilation:
./configure --prefix=/usr                   \
    --host=$LFS_TGT                         \
    --build=$(build-aux/config.guess)       \
    --enable-install-program=hostname       \
    --enable-no-install-program=kill,uptime

# Compile the package:
make

# Install the package:
make DESTDIR=$LFS install

# Move programs to their final expected locations.
mv -v $LFS/usr/bin/chroot               $LFS/usr/sbin
mkdir -pv $LFS/usr/share/man/man8
mv -v $LFS/usr/share/man/man1/chroot.1  $LFS/usr/share/man/man8/chroot.8
sed -i 's/"1"/"8"/'                     $LFS/usr/share/man/man8/chroot.8

# Cleanup
popd \
    && rm -rf /tmp/coreutils
