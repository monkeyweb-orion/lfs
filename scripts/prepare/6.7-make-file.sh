#!/bin/bash
set -e
echo "Building file.."
echo "Approximate build time: 0.2 SBU"
echo "Required disk space: 34 MB"

# 6.7. The File package contains a utility for determining 
# the type of a given file or files.
tar -xf file-*.tar.gz -C /tmp/ \
    && mv /tmp/file-* /tmp/file \
    && pushd /tmp/file \
    && mkdir build \
    && popd \
    && pushd /tmp/file/build \
    &&  ../configure --disable-bzlib    \
        --disable-libseccomp            \
        --disable-xzlib                 \
        --disable-zlib                  \
    && make \
    && popd \
    && pushd /tmp/file \
    && ./configure --prefix=/usr --host=$LFS_TGT --build=$(./config.guess) \
    && make FILE_COMPILE=$(pwd)/build/src/file \
    && make DESTDIR=$LFS install \
    && rm -v $LFS/usr/lib/libmagic.la \
    && popd \
    && rm -rf /tmp/file
