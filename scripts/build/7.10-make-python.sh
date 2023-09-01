#!/bin/bash
set -e
echo "Building perl.."
echo "Approximate build time: 0.9 SBU"
echo "Required disk space: 364 MB"

# 7.10. The Python 3 package contains the Python development 
# environment. It is useful for object-oriented programming,
# writing scripts, prototyping large programs, or developing 
# entire applications.
tar -xf /sources/Python-*.tar.xz -C /tmp/ \
    && mv /tmp/Python-* /tmp/python \
    && pushd /tmp/python

# Prepare Python for compilation:
./configure --prefix=/usr   \
    --enable-shared         \
    --without-ensurepip

# Build the package:
make

# Install
make install

popd \
    && rm -rf /tmp/python
