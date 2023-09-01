#!/bin/bash
set -e
echo "Building gawk.."
echo "Approximate build time: 0.4 SBU"
echo "Required disk space: 44 MB"

# 8.57. Gawk package contains programs for manipulating text files
tar -xf /sources/gawk-*.tar.xz -C /tmp/ \
    && mv /tmp/gawk-* /tmp/gawk \
    && pushd /tmp/gawk

# First, ensure some unneeded files are not installed:
sed -i 's/extras//' Makefile.in

# Prepare Gawk for compilation:
./configure --prefix=/usr
make
if [ $LFS_TEST -eq 1 ]; then make check; fi
make install

# install docs
if [ $LFS_DOCS -eq 1 ]; then
    mkdir -pv /usr/share/doc/gawk-5.1.1
    cp -v doc/{awkforai.txt,*.{eps,pdf,jpg}} /usr/share/doc/gawk-5.1.1
fi

# cleanup
popd \
    && rm -rf /tmp/gawk
