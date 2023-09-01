#!/bin/bash
set -e
echo "Building sed.."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 20 MB"

# 6.14. The Sed package contains a stream editor.
tar -xf sed-*.tar.xz -C /tmp/ \
    && mv /tmp/sed-* /tmp/sed \
    && pushd /tmp/sed \
    && ./configure --prefix=/usr    \
        --host=$LFS_TGT             \
    && make \
    && make DESTDIR=$LFS install \
    && popd \
    && rm -rf /tmp/sed
