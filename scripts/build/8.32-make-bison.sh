#!/bin/bash
set -e
echo "Building Bison.."
echo "Approximate build time: 8.7 SBU"
echo "Required disk space: 63 MB"

# 8.32. The Bison package contains a parser generator.
tar -xf /sources/bison-*.tar.xz -C /tmp/ \
    && mv /tmp/bison-* /tmp/bison \
    && pushd /tmp/bison

./configure --prefix=/usr --docdir=/usr/share/doc/bison-3.8.2
make

# To test the results (about 5.5 SBU), issue:
if [ $LFS_TEST -eq 1 ]; then make check; fi

# Install the package:
make install

# cleanup
popd \
    && rm -rf /tmp/bison
