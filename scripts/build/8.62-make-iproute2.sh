#!/bin/bash
set -e
echo "Building IPRoute2.."
echo "Approximate build time: 0.2 SBU"
echo "Required disk space: 16 MB"

# 6.65. IPRoute2 package contains programs for basic and advanced
# IPV4-based networki
tar -xf /sources/iproute2-*.tar.xz -C /tmp/ \
    && mv /tmp/iproute2-* /tmp/iproute2 \
    && pushd /tmp/iproute2

sed -i /ARPD/d Makefile
rm -fv man/man8/arpd.8

# Compile the package:
make NETNS_RUN_DIR=/run/netns

# Install the package
make SBINDIR=/usr/sbin install

# If desired, install the documentation:
if [ $LFS_DOCS -eq 1 ]; then 
    mkdir -pv /usr/share/doc/iproute2-5.19.0
    cp -v COPYING README* /usr/share/doc/iproute2-5.19.0
fi

# cleanup
popd \
    && rm -rf /tmp/iproute2
