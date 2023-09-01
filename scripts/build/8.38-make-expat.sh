#!/bin/bash
set -e
echo "Building Expat.."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 12 MB"

# 8.38. The Expat package contains a stream oriented C library 
# for parsing XML.
tar -xf /sources/expat-*.tar.xz -C /tmp/ \
    && mv /tmp/expat-* /tmp/expat \
    && pushd /tmp/expat

# Prepare Expat for compilation:
./configure --prefix=/usr               \
    --disable-static                    \
    --docdir=/usr/share/doc/expat-2.4.8

# Compile the package:
make

# To test the results, issue:
if [ $LFS_TEST -eq 1 ]; then make check; fi

# Install the package:
make install

# If desired, install the documentation:
if [ $LFS_DOCS -eq 1 ]; then
    install -v -m644 doc/*.{html,css} /usr/share/doc/expat-2.4.8
fi

# Cleanup
popd \
    && rm -rf /tmp/expat
