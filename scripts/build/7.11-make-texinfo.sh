#!/bin/bash
set -e
echo "Building texinfo.."
echo "Approximate build time: 0.2 SBU"
echo "Required disk space: 113 MB"

# 7.11. The Texinfo package contains programs for reading, writing, and converting info pages.
tar -xf /sources/texinfo-*.tar.xz -C /tmp/ \
    && mv /tmp/texinfo-* /tmp/texinfo \
    && pushd /tmp/texinfo \
    && ./configure --prefix=/usr \
    && make \
    && make install \
    && popd \
    && rm -rf /tmp/texinfo
