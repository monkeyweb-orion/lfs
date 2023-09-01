#!/bin/bash
set -e
echo "Building tar.."
echo "Approximate build time: 0.2 SBU"
echo "Required disk space: 38 MB"

# 6.15. The Tar package provides the ability to create 
# tar archives as well as perform various other kinds 
# of archive manipulation. Tar can be used on previously 
# created archives to extract files, to store additional 
# files, or to update or list files which were already stored.
tar -xf tar-*.tar.xz -C /tmp/ \
    && mv /tmp/tar-* /tmp/tar \
    && pushd /tmp/tar \
    && ./configure --prefix=/usr            \
        --host=$LFS_TGT                     \
        --build=$(build-aux/config.guess)   \
    && make \
    && make DESTDIR=$LFS install \
    && popd \
    && rm -rf /tmp/tar || true
