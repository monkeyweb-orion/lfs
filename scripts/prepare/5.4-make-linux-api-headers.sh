#!/bin/bash
set -e
echo "Building Linux API Headers.."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 1.4 GB"

# 5.4.  The Linux API Headers (in linux-5.19.2.tar.xz) 
# expose the kernel's API for use by Glibc.
tar -xf linux-*.tar.xz -C /tmp/                         \
    && mv /tmp/linux-* /tmp/linux                       \
    && pushd /tmp/linux                                 \
    && make mrproper                                    \
    && make headers                                     \
    && find usr/include -type f ! -name '*.h' -delete   \
    && cp -rv usr/include $LFS/usr                      \
    && popd                                             \
    && rm -rf /tmp/linux