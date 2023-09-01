#!/bin/bash
set -e
echo "Building patch.."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 12 MB"

# 6.13. The Patch package contains a program for modifying 
# or creating files by applying a “patch” file typically 
# created by the diff program.
tar -xf patch-*.tar.xz -C /tmp/ \
    && mv /tmp/patch-* /tmp/patch \
    && pushd /tmp/patch \
    && ./configure --prefix=/usr            \
        --host=$LFS_TGT                     \
        --build=$(build-aux/config.guess)   \
    && make \
    && make DESTDIR=$LFS install \
    && popd \
    && rm -rf /tmp/patch
