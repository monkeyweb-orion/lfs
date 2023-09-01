#!/bin/bash
set -e
echo "Building Xz.."
echo "Approximate build time: 0.2 SBU"
echo "Required disk space: 16 MB"

# 8.8. The Xz package contains programs for compressing and 
# decompressing files. It provides capabilities for the lzma 
# and the newer xz compression formats. Compressing text 
# files with xz yields a better compression percentage than with
# the traditional gzip or bzip2 commands.
tar -xf /sources/xz-*.tar.xz -C /tmp/ \
    && mv /tmp/xz-* /tmp/xz \
    && pushd /tmp/xz

./configure --prefix=/usr           \
    --disable-static                \
    --docdir=/usr/share/doc/xz-5.2.6

make
make check
make install

# cleanup
popd \
    && rm -rf /tmp/xz
