#!/bin/bash
set -e
echo "Building Autoconf.."
echo "Approximate build time: less than 0.1 SBU (about 6.7 SBU with tests)"
echo "Required disk space: 24 MB"

# 8.44. Autoconf package contains programs for producing shell scripts
# that can automatically configure source code
tar -xf /sources/autoconf-*.tar.xz -C /tmp/ \
    && mv /tmp/autoconf-* /tmp/autoconf \
    && pushd /tmp/autoconf

# Prepare Autoconf for compilation:
./configure --prefix=/usr

# Compile the package:
make

# To test the results, issue:
if [ $LFS_TEST -eq 1 ]; then make check || true; fi

# Install the package:
make install

# cleanup
popd \
    && rm -rf /tmp/autoconf
