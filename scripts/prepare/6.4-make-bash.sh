#!/bin/bash
set -e
echo "Building bash.."
echo "Approximate build time:  0.5 SBU"
echo "Required disk space: 64 MB"

# 6.4. The Bash package contains the Bourne-Again SHell.
tar -xf bash-*.tar.gz -C /tmp/  \
    && mv /tmp/bash-* /tmp/bash \
    && pushd /tmp/bash

# Configure
./configure --prefix=/usr           \
    --build=$(support/config.guess) \
    --host=$LFS_TGT                 \
    --without-bash-malloc

# Build
make

# Install
make DESTDIR=$LFS install
ln -sv bash $LFS/bin/sh

# cleanup
popd \
    && rm -rf /tmp/bash
