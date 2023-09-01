#!/bin/bash
set -e
echo "Building gzip.."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 10 MB"

# 6.11. The Gzip package contains programs for compressing and decompressing files.
tar -xf gzip-*.tar.xz -C /tmp/ \
    && mv /tmp/gzip-* /tmp/gzip \
    && pushd /tmp/gzip \
    && ./configure --prefix=/usr --host=$LFS_TGT \
    && make \
    && make DESTDIR=$LFS install \
    && popd \
    && rm -rf /tmp/gzip
