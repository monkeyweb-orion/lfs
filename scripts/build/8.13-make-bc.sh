#!/bin/bash
set -e
echo "Building Bc.."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 7.4 MB"

# 8.13. The Bc package contains an arbitrary precision
# numeric processing language.
tar -xf /sources/bc-*.tar.xz -C /tmp/ \
    && mv /tmp/bc-* /tmp/bc \
    && pushd /tmp/bc

# Prepare Bc for compilation:
CC=gcc ./configure --prefix=/usr -G -O3 -r
make
if [ $LFS_TEST -eq 1 ]; then make test; fi
make install

popd \
  && rm -rf /tmp/bc
