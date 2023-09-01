#!/bin/bash
set -e
echo "Building make.."
echo "Approximate build time: 0.5 SBU"
echo "Required disk space: 14 MB"

# 8.65. Make package contains a program for compiling packages
tar -xf /sources/make-*.tar.gz -C /tmp/ \
    && mv /tmp/make-* /tmp/make \
    && pushd /tmp/make

# Configure
./configure --prefix=/usr

# Build
make

# Run tests
if [ $LFS_TEST -eq 1 ]; then make check; fi

# Install
make install

# cleanup
popd \
    && rm -rf /tmp/make
