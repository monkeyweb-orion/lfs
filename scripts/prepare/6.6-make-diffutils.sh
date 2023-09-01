#!/bin/bash
set -e
echo "Building diffutils.."
echo "Approximate build time: 0.2 SBU"
echo "Required disk space: 26 MB"

# 6.6. The Diffutils package contains programs that show 
# the differences between files or directories.
tar -xf diffutils-*.tar.xz -C /tmp/ \
    && mv /tmp/diffutils-* /tmp/diffutils \
    && pushd /tmp/diffutils \
    && ./configure --prefix=/usr --host=$LFS_TGT \
    && make \
    && make DESTDIR=$LFS install \
    && popd \
    && rm -rf /tmp/diffutils
