#!/bin/bash
set -e
echo "Building Automake.."
echo "Approximate build time: less than 0.1 SBU (about 7.7 SBU with tests)"
echo "Required disk space: 116 MB"

# 8.45. Automake package contains programs for generating Makefiles
# for use with Autoconf
tar -xf /sources/automake-*.tar.xz -C /tmp/ \
    && mv /tmp/automake-* /tmp/automake \
    && pushd /tmp/automake

./configure --prefix=/usr --docdir=/usr/share/doc/automake-1.16.5
make
if [ $LFS_TEST -eq 1 ]; then make -j4 check || true; fi
make install

# cleanup
popd \
    && rm -rf /tmp/automake
