#!/bin/bash
set -e
echo "Building procps-ng.."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 19 MB"

# 8.72. The Procps-ng package contains programs for monitoring processes.
tar -xf /sources/procps-ng-*.tar.xz -C /tmp/ \
    && mv /tmp/procps-ng-* /tmp/procps-ng \
    && pushd /tmp/procps-ng

# prepare for compilation
./configure --prefix=/usr                   \
    --docdir=/usr/share/doc/procps-ng-4.0.0 \
    --disable-static                        \
    --disable-kill

# compile, test and install
make

# Run tests
if [ $LFS_TEST -eq 1 ]; then make check || true; fi

# Install package
make install

# cleanup
popd \
    && rm -rf /tmp/procps-ng
