#!/bin/bash
set -e
echo "Building make.."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 15 MB"

# 6.12. The Make package contains a program for controlling the 
# generation of executables and other non-source files of a 
# package from source files.
tar -xf make-*.tar.gz -C /tmp/ \
    && mv /tmp/make-* /tmp/make \
    && pushd /tmp/make

# Prepare Make for compilation:
./configure --prefix=/usr               \
    --without-guile                     \
    --host=$LFS_TGT                     \
    --build=$(build-aux/config.guess)

# Compile the package:
make

# Install the package:
make DESTDIR=$LFS install

# Cleanup
popd \
    && rm -rf /tmp/make
