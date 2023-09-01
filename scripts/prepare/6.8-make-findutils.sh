#!/bin/bash
set -e
echo "Building findutils.."
echo "Approximate build time: 0.2 SBU"
echo "Required disk space: 42 MB"

# 6.8. The Findutils package contains programs to find files. 
# These programs are provided to recursively search through a
# directory tree and to create, maintain, and search a database 
# (often faster than the recursive find, but is unreliable if
# the database has not been recently updated).
tar -xf findutils-*.tar.xz -C /tmp/ \
    && mv /tmp/findutils-* /tmp/findutils \
    && pushd /tmp/findutils \
    && ./configure --prefix=/usr            \
        --localstatedir=/var/lib/locate     \
        --host=$LFS_TGT                     \
        --build=$(build-aux/config.guess)   \
    && make \
    && make DESTDIR=$LFS install \
    && popd \
    && rm -rf /tmp/findutils
