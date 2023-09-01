#!/bin/bash
set -e
echo "Building Libffi.."
echo "Approximate build time: 1.8 SBU"
echo "Required disk space: 10 MB"

# 8.49. The Libffi library provides a portable, high level programming
# interface to various calling conventions. This allows a programmer
# to call any function specified by a call interface description at
# run time.
tar -xf /sources/libffi-*.tar.gz -C /tmp/ \
    && mv /tmp/libffi-* /tmp/libffi \
    && pushd /tmp/libffi

# prepare for compilation
./configure --prefix=/usr       \
    --disable-static            \
    --with-gcc-arch=native      \
    --disable-exec-static-tramp

# compile, test and install
make

# run tests
if [ $LFS_TEST -eq 1 ]; then make check || true; fi

make install

# cleanup
popd \
    && rm -rf /tmp/libffi
